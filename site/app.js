/* Tableau de bord P4 : lecture du classeur D6 (API gviz de Google Sheets), recalcul des statuts
   avec les règles du classeur, rendu ECharts. Copie de secours : data/snapshot.json. */
"use strict";

const SCENARIOS = ["Tensions", "Défavorable", "Intermédiaire", "Favorable"];
const SCEN_VAR = { Tensions: "--scen-tensions", "Défavorable": "--scen-defavorable", "Intermédiaire": "--scen-intermediaire", Favorable: "--scen-favorable" };
const DOMAINS = ["Délais", "Coûts", "Périmètre", "Qualité", "Risques", "Ressources"];
const RANK = { Vert: 1, Orange: 2, Rouge: 3 };
const HIGH = "Plus haut est mieux";
const RUBRIQUES = ["Récit", "Vulnérabilité", "Choc", "Levier", "Jalon", "Issue"];
const DAY = 86400000;
const FONT = '"IBM Plex Mono", ui-monospace, Menlo, Consolas, monospace';

const state = { model: null, scenario: "Intermédiaire", dayIndex: 0, view: "situation", charts: {}, playing: null };

/* -------------------------------------------------------------------------- */
/* Lecture des données                                                         */
/* -------------------------------------------------------------------------- */
function parseGviz(text) {
  const body = JSON.parse(text.slice(text.indexOf("(") + 1, text.lastIndexOf(")")));
  if (body.status !== "ok") throw new Error((body.errors || []).map(e => e.detailed_message || e.message).join(" ; ") || "réponse en erreur");
  return body.table.rows.map(r => r.c.map(c => c || null));
}

async function fetchLive(sources) {
  const entries = Object.entries(sources.queries);
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), 12000);
  try {
    const texts = await Promise.all(entries.map(([, [sheet, range]]) => {
      const q = new URLSearchParams({ tqx: "out:json", headers: "0", sheet, range });
      const url = `https://docs.google.com/spreadsheets/d/${sources.sheetId}/gviz/tq?${q}`;
      return fetch(url, { signal: ctrl.signal, cache: "no-store" }).then(r => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.text();
      });
    }));
    return Object.fromEntries(entries.map(([k], i) => [k, texts[i]]));
  } finally {
    clearTimeout(timer);
  }
}

// Valeurs de cellule : gviz renvoie v (brut) et f (formaté) ; une colonne de types mêlés arrive en texte.
const str = c => (c == null || c.v == null || String(c.v).trim() === "") ? null : String(c.v).trim();
function num(c) {
  if (c == null || c.v == null) return null;
  if (typeof c.v === "number") return c.v;
  let s = String(c.v).replace(/[\s  €]/g, "");
  if (!s) return null;
  const pct = s.endsWith("%");
  s = s.replace("%", "").replace(",", ".").replace("−", "-");
  const n = parseFloat(s);
  return Number.isNaN(n) ? null : (pct ? n / 100 : n);
}
function day(c) {
  if (c == null || c.v == null) return null;
  const s = String(c.v);
  let m = s.match(/^Date\((\d+),(\d+),(\d+)/);
  if (m) return Date.UTC(+m[1], +m[2], +m[3]) / DAY;
  m = s.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})/);
  if (m) return Date.UTC(+m[3], +m[2] - 1, +m[1]) / DAY;
  return null;
}

function buildModel(res) {
  const t = k => { if (!(k in res)) throw new Error(`plage ${k} absente`); return parseGviz(res[k]); };
  const params = Object.fromEntries(t("params").filter(r => str(r[0])).map(r => [str(r[0]), r[1]]));
  const need = ["Date de situation", "Date de fin prévue (référence G1)", "Coût prévisionnel hors provision (€)", "Scénario actif"];
  for (const k of need) if (!(k in params)) throw new Error(`paramètre « ${k} » introuvable (ancienne version du classeur ?)`);
  const kpis = t("kpi").filter(r => str(r[0])).map(r => ({
    code: str(r[0]), domaine: str(r[1]), name: str(r[2]), def: str(r[3]), source: str(r[4]), freq: str(r[5]),
    sens: str(r[6]), cible: num(r[7]), alerte: num(r[8]), critique: num(r[9]),
  }));
  const ctx = t("ctx").filter(r => str(r[0])).map(r => ({ code: str(r[0]), domaine: str(r[1]), name: str(r[2]), def: str(r[3]) }));
  const scen = {};
  for (const s of SCENARIOS) {
    const hypRows = t(`hyp:${s}`).filter(r => str(r[0]));
    const bad = hypRows.map(r => str(r[0])).filter(x => !RUBRIQUES.includes(x));
    if (bad.length) throw new Error(`structure inattendue dans l'onglet Relevés ${s} (${bad[0]}) : classeur d'une autre version`);
    const hyp = hypRows.map(r => ({
      rub: str(r[0]), date: day(r[1]), code: str(r[2]), lib: str(r[3]), montant: num(r[5]), effet: str(r[6]),
    }));
    const rel = t(`rel:${s}`).filter(r => day(r[0]) != null && str(r[2]) && num(r[5]) != null).map(r => ({
      date: day(r[0]), occ: str(r[1]) || "", code: str(r[2]), val: num(r[5]), source: str(r[6]), com: str(r[7]),
    })).sort((a, b) => a.date - b.date);
    const jour = t(`jour:${s}`).filter(r => day(r[0]) != null && str(r[2])).map(r => ({
      date: day(r[0]), dom: str(r[1]) || "Général", fait: str(r[2]), dec: str(r[3]),
    })).sort((a, b) => a.date - b.date);
    const byCode = {};
    for (const r of rel) (byCode[r.code] ||= []).push(r);
    scen[s] = { name: s, hyp, rel, jour, byCode,
      start: rel.length ? rel[0].date : null, end: rel.length ? rel[rel.length - 1].date : null };
  }
  const synth = {
    attention: t("attention").map(r => str(r[0])).filter(Boolean),
    risques: t("risques").filter(r => str(r[0])).map(r => ({ id: str(r[0]), crit: num(r[1]), niveau: str(r[2]), risque: str(r[3]), action: str(r[4]) })),
    actions: t("actions").filter(r => str(r[3])).map(r => ({ date: day(r[0]), statut: str(r[1]), resp: str(r[2]), action: str(r[3]), com: str(r[4]) })),
  };
  const jalons = t("jalons").filter(r => str(r[0])).map(r => ({ code: str(r[0]), prevu: day(r[1]), label: str(r[2]) }));
  const starts = SCENARIOS.map(s => scen[s].start).filter(x => x != null);
  const ends = SCENARIOS.map(s => scen[s].end).filter(x => x != null);
  if (!starts.length) throw new Error("aucun relevé trouvé dans les onglets de scénarios");
  const weeks = [];
  for (let d = Math.min(...starts); d <= Math.max(...ends); d += 7) weeks.push(d);
  const active = str(params["Scénario actif"]);
  return {
    situation: day(params["Date de situation"]), finRef: day(params["Date de fin prévue (référence G1)"]),
    budget: num(params["Budget de référence (€)"]), cost: num(params["Coût prévisionnel hors provision (€)"]),
    active: SCENARIOS.includes(active) ? active : "Intermédiaire",
    projet: str(params["Nom du projet"]), kpis, ctx, scen, synth, jalons, weeks,
  };
}

/* -------------------------------------------------------------------------- */
/* Moteur de statuts : mêmes règles que les formules du classeur (onglets KPI, Historique)                */
/* -------------------------------------------------------------------------- */
function asOf(sc, code, d, strict = false) {
  const list = sc.byCode[code] || [];
  let hit = null;
  for (const r of list) { if (strict ? r.date < d : r.date <= d) hit = r; else break; }
  return hit;
}
function kpiStatus(k, v) {
  if (v == null || k.alerte == null || k.critique == null) return null;
  if (k.sens === HIGH) return v <= k.critique ? "Rouge" : v <= k.alerte ? "Orange" : "Vert";
  return v >= k.critique ? "Rouge" : v >= k.alerte ? "Orange" : "Vert";
}
function trendOf(k, cur, prev) {
  if (cur == null || prev == null) return null;
  if (cur === prev) return "Stable";
  return (cur > prev) === (k.sens === HIGH) ? "En amélioration" : "En dégradation";
}
const worst = list => { const s = list.filter(x => x in RANK); return s.length ? s.reduce((a, b) => RANK[b] > RANK[a] ? b : a) : null; };

function situation(model, sc, d) {
  const kp = {};
  for (const k of model.kpis) {
    const last = asOf(sc, k.code, d);
    const prev = last ? asOf(sc, k.code, last.date, true) : null;
    kp[k.code] = { k, last, prev, status: last ? kpiStatus(k, last.val) : null, trend: last && prev ? trendOf(k, last.val, prev.val) : null };
  }
  const doms = {}, domTrend = {};
  for (const dom of DOMAINS) {
    const items = model.kpis.filter(k => k.domaine === dom).map(k => kp[k.code]);
    doms[dom] = worst(items.map(i => i.status));
    const tr = items.map(i => i.trend);
    domTrend[dom] = tr.includes("En dégradation") ? "En dégradation" : tr.includes("En amélioration") ? "En amélioration" : tr.includes("Stable") ? "Stable" : null;
  }
  return { kp, doms, domTrend, global: worst(Object.values(doms)) };
}
const ctxVal = (sc, code, d) => { const r = asOf(sc, code, d); return r ? r.val : null; };

/* -------------------------------------------------------------------------- */
/* Formats                                                                     */
/* -------------------------------------------------------------------------- */
const nf0 = new Intl.NumberFormat("fr-FR", { maximumFractionDigits: 0 });
const pf0 = new Intl.NumberFormat("fr-FR", { style: "percent", maximumFractionDigits: 0 });
const pf1 = new Intl.NumberFormat("fr-FR", { style: "percent", minimumFractionDigits: 1, maximumFractionDigits: 1 });
const eur = v => v == null ? "" : `${nf0.format(v)} €`;
const keur = v => v == null ? "" : `${nf0.format(Math.round(v / 1000))} k€`;
const fdate = d => { if (d == null) return ""; const x = new Date(d * DAY); return `${String(x.getUTCDate()).padStart(2, "0")}/${String(x.getUTCMonth() + 1).padStart(2, "0")}/${x.getUTCFullYear()}`; };
const fshort = d => fdate(d).slice(0, 5);
function isoWeek(d) {
  const x = new Date(d * DAY); const t = new Date(Date.UTC(x.getUTCFullYear(), x.getUTCMonth(), x.getUTCDate()));
  t.setUTCDate(t.getUTCDate() + 4 - (t.getUTCDay() || 7));
  const y0 = new Date(Date.UTC(t.getUTCFullYear(), 0, 1));
  return `S${String(Math.ceil(((t - y0) / DAY + 1) / 7)).padStart(2, "0")}`;
}
function fval(code, v) {
  if (v == null) return "";
  if (["DEL-JAL", "COU-CHA", "PER-EXI", "RES-OCC", "CTX-AVR", "CTX-AVP"].includes(code)) return pf0.format(v);
  if (code === "COU-ECA") return (v > 0 ? "+" : "") + pf1.format(v);
  if (code === "DEL-AV") return `${v > 0 ? "+" : ""}${nf0.format(v)} pt${Math.abs(v) > 1 ? "s" : ""}`;
  if (code === "DEL-FIN") return v === 0 ? "0 semaine" : `+${nf0.format(v)} sem.`;
  if (code.startsWith("CTX-") && code !== "CTX-CRIT") return eur(v);
  return nf0.format(v);
}
const esc = s => String(s ?? "").replace(/[&<>"]/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
const css = name => getComputedStyle(document.documentElement).getPropertyValue(name).trim();
const scenColor = s => css(SCEN_VAR[s]);
const statusClass = s => ({ Vert: "vert", Orange: "orange", Rouge: "rouge" }[s] || "none");
const ICONS = {
  Vert: '<svg viewBox="0 0 16 16" aria-hidden="true"><circle cx="8" cy="8" r="7" fill="currentColor"/><path d="M4.5 8.2l2.2 2.2 4.8-4.8" stroke="#fff" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  Orange: '<svg viewBox="0 0 16 16" aria-hidden="true"><path d="M8 1.2l7 12.6H1z" fill="currentColor"/><path d="M8 5.6v4.2M8 11.6v.3" stroke="#fff" stroke-width="1.8" stroke-linecap="round"/></svg>',
  Rouge: '<svg viewBox="0 0 16 16" aria-hidden="true"><path d="M5.1 1h5.8L15 5.1v5.8L10.9 15H5.1L1 10.9V5.1z" fill="currentColor"/><path d="M5.6 5.6l4.8 4.8M10.4 5.6l-4.8 4.8" stroke="#fff" stroke-width="1.8" stroke-linecap="round"/></svg>',
  none: '<svg viewBox="0 0 16 16" aria-hidden="true"><circle cx="8" cy="8" r="6.2" fill="none" stroke="currentColor" stroke-width="1.6"/><path d="M5 8h6" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>',
};
const statusHTML = s => `<span class="status ${statusClass(s)}">${ICONS[s] || ICONS.none}${esc(s || "Non mesuré")}</span>`;
const chipHTML = s => `<span class="chip ${statusClass(s)}">${esc(s || "N/M")}</span>`;
const trendArrow = t => ({ "En amélioration": "▲ amélioration", "En dégradation": "▼ dégradation", Stable: "■ stable" }[t] || "");
const heat = s => css({ Vert: "--heat-vert", Orange: "--heat-orange", Rouge: "--heat-rouge" }[s] || "--heat-none");
const stColor = s => css({ Vert: "--st-vert", Orange: "--st-orange", Rouge: "--st-rouge" }[s] || "--muted");

/* -------------------------------------------------------------------------- */
/* ECharts : options communes                                                  */
/* -------------------------------------------------------------------------- */
function chart(id) {
  const el = document.getElementById(id);
  let c = state.charts[id];
  if (!c) { c = echarts.init(el, null, { renderer: "svg" }); state.charts[id] = c; }
  return c;
}
function base() {
  const ink2 = css("--ink-2"), muted = css("--muted"), grid = css("--grid"), axis = css("--axis");
  return {
    animationDuration: 300,
    textStyle: { fontFamily: FONT, color: ink2, fontSize: 10 },
    grid: { left: 8, right: 16, top: 26, bottom: 6, containLabel: true },
    tooltip: {
      trigger: "axis", confine: true, backgroundColor: css("--surface"), borderColor: css("--bar"), borderWidth: 1, padding: [6, 8],
      textStyle: { color: css("--ink"), fontSize: 11, fontFamily: FONT }, extraCssText: "border-radius: 0; box-shadow: 0 2px 8px rgba(0,0,0,.15);",
    },
    xAxisTime: {
      type: "time", axisLine: { lineStyle: { color: axis } }, axisTick: { show: false },
      axisLabel: { color: muted, hideOverlap: true, fontSize: 10, formatter: v => fshort(v / DAY) }, splitLine: { show: false },
    },
    yAxis: { axisLine: { show: false }, axisTick: { show: false }, axisLabel: { color: muted, fontSize: 10 }, splitLine: { lineStyle: { color: grid } } },
    legend: { top: 2, left: 0, icon: "rect", itemWidth: 10, itemHeight: 3, textStyle: { color: ink2, fontSize: 10, fontFamily: FONT } },
  };
}
const ms = d => d * DAY;
const lineSeries = (name, data, color, extra = {}) => ({
  name, type: "line", data, showSymbol: false, symbolSize: 8, lineStyle: { width: 2, color }, itemStyle: { color },
  emphasis: { focus: "series" }, connectNulls: false, ...extra,
});
function situationLine(d) {
  return {
    silent: true, symbol: "none", lineStyle: { color: css("--ink-2"), width: 1, type: "solid" },
    label: { formatter: "SITUATION", color: css("--ink-2"), fontSize: 9, position: "insideEndTop" },
    data: [{ xAxis: ms(d) }],
  };
}
function axisTooltip(fmt) {
  return params => {
    const ps = Array.isArray(params) ? params : [params];
    if (!ps.length) return "";
    const d = (Array.isArray(ps[0].value) ? ps[0].value[0] : ps[0].axisValue) / DAY;
    const rows = ps.filter(p => p.value && p.value[1] != null && p.seriesType !== "scatter")
      .map(p => `<div style="display:flex;gap:8px;justify-content:space-between"><span>${p.marker}${esc(p.seriesName)}</span><b>${fmt(p.value[1], p.seriesName)}</b></div>`);
    return `<div style="min-width:170px"><div style="color:${css("--muted")}">${isoWeek(d)} · ${fdate(d)}</div>${rows.join("")}</div>`;
  };
}

/* -------------------------------------------------------------------------- */
/* Vue Situation                                                               */
/* -------------------------------------------------------------------------- */
function currentDay() { return state.model.weeks[state.dayIndex]; }

function renderSituation() {
  const m = state.model, sc = m.scen[state.scenario], d = currentDay();
  const cut = Math.min(d, sc.end);
  const st = situation(m, sc, d);
  const closed = d > sc.end;

  const nbAlert = Object.values(st.doms).filter(x => x === "Orange" || x === "Rouge").length;
  const note = closed ? `Clôturé le ${fshort(sc.end)}` : `${nbAlert}/6 hors tolérance`;
  const card = (cls, name, status, sub) => `<li class="${cls} ${statusClass(status)}"><span class="dom-name">${esc(name)}</span><span class="trend">${sub}</span></li>`;
  document.getElementById("meteo").innerHTML = card("global", "Statut global", st.global, note) +
    DOMAINS.map(dom => card("", dom, st.doms[dom], trendArrow(st.domTrend[dom]) || "Non mesuré")).join("");

  renderTiles(m, sc, d, st);
  renderAvancement(m, sc, d);
  renderBudget(m, sc, d);
  renderFrise(m, sc, d);
  renderKpis(m, sc, d, st);
  renderBand("chart-occupation", sc, "RES-OCC", cut, m, v => pf0.format(v));
  renderBand("chart-risques", sc, "CTX-CRIT", cut, m, v => nf0.format(v));
  renderCalendrier(m, sc, d);
  renderJournal(sc, d);
  renderSynthese(m);
  renderReleves(m, sc, d);
}

function renderTiles(m, sc, d, st) {
  const avr = ctxVal(sc, "CTX-AVR", d), avp = ctxVal(sc, "CTX-AVP", d);
  const eac = ctxVal(sc, "CTX-EAC", d), eca = st.kp["COU-ECA"].last?.val;
  const fin = st.kp["DEL-FIN"].last?.val, occ = st.kp["RES-OCC"].last?.val;
  const jal = sc.hyp.filter(h => h.rub === "Jalon" && h.date != null && h.date > d).sort((a, b) => a.date - b.date)[0];
  const prevu = jal ? m.jalons.find(j => j.code === jal.code) : null;
  const deltaClass = s => ({ Rouge: "bad", Orange: "warn", Vert: "good" }[s] || "");
  const av = avr != null && avp != null ? Math.round((avr - avp) * 100) : null;
  const tiles = [
    { label: "Avancement", value: avr == null ? "" : pf0.format(avr), delta: av == null ? "" : fval("DEL-AV", av),
      detail: avp == null ? "" : `plan ${pf0.format(avp)}`, st: av == null ? null : kpiStatus(st.kp["DEL-AV"].k, av) },
    { label: "Prévision à fin", value: keur(eac), delta: eca == null ? "" : fval("COU-ECA", eca), detail: `budget ${keur(m.cost)}`, st: st.kp["COU-ECA"].status },
    { label: "Fin re-prévue", value: fin == null ? "" : fdate(m.finRef + 7 * fin), delta: fin == null ? "" : fval("DEL-FIN", fin),
      detail: `réf. ${fdate(m.finRef)}`, st: st.kp["DEL-FIN"].status },
    { label: "Prochain jalon", value: jal ? `${jal.code} ${fshort(jal.date)}` : "—", delta: jal ? `J-${Math.round(jal.date - d)}` : "",
      detail: jal && prevu && prevu.prevu !== jal.date ? `prévu ${fshort(prevu.prevu)}` : jal ? "à l'heure" : "tous franchis", st: null },
    { label: "Occupation dév.", value: occ == null ? "" : pf0.format(occ), delta: st.kp["RES-OCC"].trend ? trendArrow(st.kp["RES-OCC"].trend).split(" ")[0] : "",
      detail: "cible 80 %", st: st.kp["RES-OCC"].status },
  ];
  document.getElementById("tiles").innerHTML = tiles.map(t =>
    `<div class="tile ${statusClass(t.st)}"><p class="label">${esc(t.label)}</p><p class="value">${esc(t.value)}</p><p class="detail"><span class="delta ${deltaClass(t.st)}">${esc(t.delta)}</span>${t.delta ? " · " : ""}${esc(t.detail)}</p></div>`).join("");
}

function series(sc, code, until) {
  return (sc.byCode[code] || []).filter(r => until == null || r.date <= until).map(r => [ms(r.date), r.val]);
}

function renderAvancement(m, sc, d) {
  const b = base(), col = scenColor(sc.name), cut = Math.min(d, sc.end);
  const planned = series(sc, "CTX-AVP");
  const real = series(sc, "CTX-AVR", cut);
  const jalReels = sc.hyp.filter(h => h.rub === "Jalon" && h.date != null && h.date <= cut && h.date >= m.weeks[0])
    .map(h => ({ value: [ms(h.date), ctxVal(sc, "CTX-AVR", h.date)], name: h.code, late: (m.jalons.find(j => j.code === h.code)?.prevu ?? h.date) < h.date }));
  chart("chart-avancement").setOption({
    ...b, xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]), max: ms(sc.end) },
    yAxis: { ...b.yAxis, type: "value", min: 0, max: 1, axisLabel: { ...b.yAxis.axisLabel, formatter: v => pf0.format(v) } },
    tooltip: { ...b.tooltip, formatter: axisTooltip(v => pf0.format(v)) },
    legend: { ...b.legend, data: ["Réel", "Planifié", "Jalon franchi"] },
    series: [
      lineSeries("Planifié", planned, css("--planned")),
      lineSeries("Réel", real, col, { areaStyle: { color: col, opacity: 0.1 }, endLabel: { show: true, formatter: p => pf0.format(p.value[1]), color: css("--ink") },
        markLine: situationLine(d),
        markArea: { silent: true, itemStyle: { color: css("--grid"), opacity: 0.35 },
          data: m.jalons.filter(j => j.prevu >= m.weeks[0]).map(j => [{ xAxis: ms(j.prevu) - DAY / 2, name: j.code, label: { color: css("--muted"), fontSize: 10, position: "insideTop" } }, { xAxis: ms(j.prevu) + DAY / 2 }]) } }),
      { name: "Jalon franchi", type: "scatter", symbol: "diamond", symbolSize: 12, z: 5,
        itemStyle: { color: col, borderColor: css("--surface"), borderWidth: 2 },
        label: { show: true, position: "top", formatter: p => p.data.name, color: css("--ink"), fontSize: 10, fontWeight: 600 },
        tooltip: { trigger: "item", formatter: p => `Jalon ${esc(p.data.name)} franchi le ${fdate(p.value[0] / DAY)}${p.data.late ? " (en retard)" : " (à l'heure)"}` },
        data: jalReels },
    ],
  }, true);
}

function renderBudget(m, sc, d) {
  const b = base(), col = scenColor(sc.name), cut = Math.min(d, sc.end);
  const ref = (y, label, color, position = "insideStartTop") => ({ yAxis: y, label: { formatter: label, color, fontSize: 11, position }, lineStyle: { color, width: 1, type: "solid" } });
  chart("chart-budget").setOption({
    ...b, xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]), max: ms(sc.end) },
    yAxis: { ...b.yAxis, type: "value", min: 0, max: v => Math.max(v.max, m.budget) * 1.05, axisLabel: { ...b.yAxis.axisLabel, formatter: v => keur(v) } },
    tooltip: { ...b.tooltip, formatter: axisTooltip(v => eur(v)) },
    legend: { ...b.legend, data: ["Consommé", "Prévision à fin", "Budget prévu"] },
    series: [
      lineSeries("Budget prévu", series(sc, "CTX-PV"), css("--planned")),
      lineSeries("Consommé", series(sc, "CTX-CONS", cut), col, { areaStyle: { color: col, opacity: 0.1 }, markLine: situationLine(d) }),
      lineSeries("Prévision à fin", series(sc, "CTX-EAC", cut), css("--ink-2"), {
        endLabel: { show: true, formatter: p => keur(p.value[1]), color: css("--ink") },
        markLine: { silent: true, symbol: "none", data: [ref(m.cost, `Coût prévu ${keur(m.cost)}`, css("--muted"), "insideStartBottom"), ref(m.budget, `Enveloppe ${keur(m.budget)}`, css("--st-rouge"))] } }),
    ],
  }, true);
}

function weekCells(m, sc, uptoDay) {
  return m.weeks.filter(w => w <= Math.max(sc.end, m.weeks[0])).map(w => ({ w, st: w <= uptoDay ? situation(m, sc, w) : null }));
}
function weekFact(sc, w) {
  const e = sc.jour.filter(j => j.dom === "Général" && j.date <= w && j.date > w - 7).pop();
  return e ? `${esc(e.fait)}${e.dec ? `<br><span style="color:${css("--muted")}">Décision : ${esc(e.dec)}</span>` : ""}` : "";
}

function renderFrise(m, sc, d) {
  const b = base(), rows = ["Statut global", ...DOMAINS];
  const cells = weekCells(m, sc, d);
  const data = [];
  cells.forEach((c, x) => rows.forEach((r, y) => {
    const s = c.st ? (y === 0 ? c.st.global : c.st.doms[r]) : undefined;
    data.push({ value: [x, rows.length - 1 - y, RANK[s] || 0], status: s || "", itemStyle: { color: c.st ? heat(s) : css("--heat-future"), borderColor: css("--surface"), borderWidth: 1, borderRadius: 0 } });
  }));
  chart("chart-frise").setOption({
    ...b, grid: { left: 104, right: 8, top: 8, bottom: 24, containLabel: false },
    tooltip: { ...b.tooltip, trigger: "item", formatter: p => {
      const c = cells[p.value[0]], r = rows[rows.length - 1 - p.value[1]];
      if (!c.st) return `${isoWeek(c.w)} · ${fdate(c.w)} : à venir`;
      const fact = weekFact(sc, c.w);
      return `<div style="max-width:300px;white-space:normal"><div style="color:${css("--muted")}">${isoWeek(c.w)} · ${fdate(c.w)}</div><b>${esc(r)} : ${esc(p.data.status || "Non mesuré")}</b>${fact ? `<div style="margin-top:4px">${fact}</div>` : ""}</div>`;
    } },
    xAxis: { type: "category", data: cells.map(c => isoWeek(c.w)), axisLine: { show: false }, axisTick: { show: false }, splitLine: { show: false },
      axisLabel: { color: css("--muted"), fontSize: 10, interval: "auto", hideOverlap: true } },
    yAxis: { type: "category", data: [...rows].reverse(), axisLine: { show: false }, axisTick: { show: false },
      axisLabel: { color: css("--ink-2"), fontSize: 10, width: 96, overflow: "truncate" } },
    series: [{ type: "heatmap", data, emphasis: { itemStyle: { borderColor: css("--ink"), borderWidth: 2 } } }],
  }, true);
  document.getElementById("legend-status").innerHTML = ["Vert", "Orange", "Rouge"].map(s =>
    `<span><span class="key-sw" style="background:${heat(s)}"></span>${s}</span>`).join("") +
    `<span><span class="key-sw" style="background:${css("--heat-none")}"></span>N/M</span>`;
}

function lastFridayOfMonth(y, mo) { let x = Date.UTC(y, mo + 1, 0) / DAY; while (new Date(x * DAY).getUTCDay() !== 5) x--; return x; }
function nextExpected(m, sc, k, last) {
  const jalonsApres = sc.hyp.filter(h => h.rub === "Jalon" && h.date != null && h.date > last.date).map(h => h.date);
  if ((k.freq || "").startsWith("Hebdo")) return last.date + 7;
  if ((k.freq || "").startsWith("Mensuel")) {
    const x = new Date(last.date * DAY);
    let lf = lastFridayOfMonth(x.getUTCFullYear(), x.getUTCMonth());
    if (lf <= last.date) lf = lastFridayOfMonth(x.getUTCFullYear(), x.getUTCMonth() + 1);
    return Math.min(lf, ...jalonsApres);
  }
  return jalonsApres.length ? Math.min(...jalonsApres) : null;
}

function spark(k, pts, color) {
  const W = 260, H = 56, P = 3;
  if (!pts.length) return `<svg class="spark" viewBox="0 0 ${W} ${H}" aria-hidden="true"></svg>`;
  const vals = pts.map(p => p.val).concat([k.alerte, k.critique, k.cible].filter(v => v != null));
  let lo = Math.min(...vals), hi = Math.max(...vals);
  const span = Math.abs(k.alerte - k.critique) * 0.8;
  if (k.sens === HIGH) lo = Math.min(lo, k.critique - span); else hi = Math.max(hi, k.critique + span);
  if (hi === lo) { hi += 1; lo -= 1; }
  const pad = (hi - lo) * 0.08; lo -= pad; hi += pad;
  const t0 = state.model.weeks[0], t1 = Math.max(pts[pts.length - 1].date, t0 + 7);
  const X = t => P + (W - 2 * P) * (t - t0) / (t1 - t0), Y = v => H - P - (H - 2 * P) * (v - lo) / (hi - lo);
  // Sur fond coloré : seuils d'alerte et critique en filets, courbe dans la couleur du texte de la carte
  const rule = (v, op) => `<line x1="0" x2="${W}" y1="${Y(v)}" y2="${Y(v)}" stroke="currentColor" stroke-opacity="${op}" stroke-width="1" vector-effect="non-scaling-stroke"/>`;
  const bands = rule(k.alerte, 0.35) + rule(k.critique, 0.6);
  let path = `M${X(pts[0].date)},${Y(pts[0].val)}`;
  for (let i = 1; i < pts.length; i++) path += `H${X(pts[i].date)}V${Y(pts[i].val)}`;
  const lp = pts[pts.length - 1];
  return `<svg class="spark" viewBox="0 0 ${W} ${H}" preserveAspectRatio="none" aria-hidden="true">${bands}
    <path d="${path}" fill="none" stroke="${color}" stroke-width="2" vector-effect="non-scaling-stroke" stroke-linejoin="round"/>
    <circle cx="${X(lp.date)}" cy="${Y(lp.val)}" r="3" fill="${color}"/></svg>`;
}

function renderKpis(m, sc, d, st) {
  const col = "currentColor";
  document.getElementById("kpis").innerHTML = m.kpis.map(k => {
    const s = st.kp[k.code], last = s.last;
    const pts = (sc.byCode[k.code] || []).filter(r => r.date <= d);
    let meta;
    if (!last) meta = `<p class="meta">${k.code === "PER-EXI" ? "Mesuré en recette" : "Aucun relevé"}</p>`;
    else {
      const nxt = d <= sc.end ? nextExpected(m, sc, k, last) : null;
      const late = nxt != null && d > nxt;
      meta = `<p class="meta${late ? " late" : ""}">MAJ ${fshort(last.date)}${nxt ? ` · ${late ? "⚠ EN RETARD" : "PROCH."} ${fshort(nxt)}` : ""}</p>`;
    }
    const prev = s.prev ? `<span class="trend">${esc(trendArrow(s.trend).split(" ")[0] || "")} ${esc(fval(k.code, s.prev.val))}</span>` : "";
    const title = [k.def, last && last.com].filter(Boolean).join(" · ");
    return `<article class="kpi ${statusClass(s.status)}" title="${esc(title)}">
      <div class="kpi-head"><span class="kpi-code">${esc(k.code)}</span></div>
      <span class="kpi-name">${esc(k.name.replace(/ \((%|points|semaines)\)$/, ""))}</span>
      <div class="kpi-value"><span class="big">${last ? esc(fval(k.code, last.val)) : "—"}</span>${prev}</div>
      ${spark(k, pts, col)}
      ${meta}
    </article>`;
  }).join("");
}

function renderBand(id, sc, code, cut, m, fmt) {
  const b = base(), col = scenColor(sc.name), k = m.kpis.find(x => x.code === code);
  const pts = series(sc, code, cut);
  const areas = [];
  if (k) {
    areas.push([{ yAxis: k.alerte, itemStyle: { color: css("--band-orange") } }, { yAxis: k.critique }]);
    areas.push([{ yAxis: k.critique, itemStyle: { color: css("--band-rouge") } }, { yAxis: 10 }]);
  }
  chart(id).setOption({
    ...b, grid: { ...b.grid, top: 16 }, legend: { show: false },
    xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]), max: ms(sc.end) },
    yAxis: { ...b.yAxis, type: "value", min: k ? 0.4 : 0, max: k ? 1.6 : null, axisLabel: { ...b.yAxis.axisLabel, formatter: v => fmt(v) } },
    tooltip: { ...b.tooltip, formatter: axisTooltip(v => fmt(v)) },
    series: [lineSeries(k ? k.name : "Criticité cumulée", pts, col, {
      step: k ? "end" : false, areaStyle: k ? undefined : { color: col, opacity: 0.1 },
      endLabel: { show: true, formatter: p => fmt(p.value[1]), color: css("--ink") },
      markArea: k ? { silent: true, data: areas } : undefined,
      markLine: k ? { silent: true, symbol: "none", data: [{ yAxis: k.cible, label: { formatter: `Cible ${fmt(k.cible)}`, color: css("--muted"), fontSize: 11, position: "insideStartTop" }, lineStyle: { color: css("--muted"), width: 1, type: "solid" } }] } : situationLine(currentDay()),
    })],
  }, true);
}

const OCC_SYMBOL = [
  ["Revue hebdomadaire", "circle", "Hebdo"],
  ["Revue mensuelle du planning", "rect", "Mensuel"],
  ["Relevé exceptionnel", "triangle", "Exceptionnel"],
  ["Jalon", "diamond", "Jalon"],
  ["Relevé de lancement", "pin", "Lancement"],
  ["Recette", "roundRect", "Recette"],
];
const occSymbol = occ => (OCC_SYMBOL.find(([p]) => occ.startsWith(p)) || OCC_SYMBOL[0])[1];

function renderCalendrier(m, sc, d) {
  const b = base(), codes = m.kpis.map(k => k.code);
  const byOcc = {};
  for (const k of m.kpis) for (const r of sc.byCode[k.code] || []) {
    if (r.date > d) continue;
    const sym = occSymbol(r.occ);
    (byOcc[sym] ||= []).push({ value: [ms(r.date), codes.indexOf(k.code)], r, k, status: kpiStatus(k, r.val) });
  }
  chart("chart-calendrier").setOption({
    ...b, grid: { left: 164, right: 16, top: 8, bottom: 28, containLabel: false },
    tooltip: { ...b.tooltip, trigger: "item", formatter: p => {
      const { r, k, status } = p.data;
      return `<div style="max-width:280px;white-space:normal"><div style="color:${css("--muted")}">${fdate(r.date)} · ${esc(r.occ)}</div><b>${esc(k.name)}</b> : ${esc(fval(k.code, r.val))} ${statusHTML(status)}${r.com ? `<div>${esc(r.com)}</div>` : ""}</div>`;
    } },
    xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]) - 3 * DAY, max: ms(sc.end) + 3 * DAY },
    yAxis: { type: "category", data: codes.map(c => m.kpis.find(k => k.code === c).name.replace(/ \((%|points|semaines)\)$/, "")), inverse: true,
      axisLine: { show: false }, axisTick: { show: false }, splitLine: { show: true, lineStyle: { color: css("--grid") } }, axisLabel: { color: css("--ink-2"), fontSize: 11, width: 156, overflow: "truncate" } },
    series: Object.entries(byOcc).map(([sym, data]) => ({
      type: "scatter", symbol: sym, symbolSize: sym === "circle" ? 8 : 12, data: data.map(x => ({ ...x, itemStyle: { color: stColor(x.status), borderColor: css("--surface"), borderWidth: 1.5 } })),
      emphasis: { scale: 1.4 },
    })).concat([{ type: "line", data: [], markLine: situationLine(d) }]),
  }, true);
  const shape = { circle: '<circle cx="7" cy="7" r="4.5"/>', rect: '<rect x="2.5" y="2.5" width="9" height="9"/>', triangle: '<path d="M7 1.5l6 11H1z"/>',
    diamond: '<path d="M7 1l6 6-6 6-6-6z"/>', pin: '<path d="M7 1a4.5 4.5 0 0 1 4.5 4.5C11.5 9 7 13 7 13S2.5 9 2.5 5.5A4.5 4.5 0 0 1 7 1z"/>', roundRect: '<rect x="2" y="3.5" width="10" height="7" rx="2.5"/>' };
  document.getElementById("legend-occasions").innerHTML = OCC_SYMBOL.map(([, sym, label]) =>
    `<span><svg viewBox="0 0 14 14" aria-hidden="true" fill="${css("--bar-hint")}">${shape[sym]}</svg>${label.replace(" (tous les indicateurs)", "")}</span>`).join("");
}

function renderJournal(sc, d) {
  const items = sc.jour.filter(j => j.date <= d).slice().reverse();
  document.getElementById("journal").innerHTML = items.map(j =>
    `<li><time datetime="${new Date(j.date * DAY).toISOString().slice(0, 10)}">${fshort(j.date)}</time><div><span class="dom">${esc(j.dom)}</span>${esc(j.fait)}${j.dec ? `<span class="dec">${esc(j.dec)}</span>` : ""}</div></li>`).join("")
    || `<li><span></span><div>Aucun fait marquant à cette date.</div></li>`;
}

function renderSynthese(m) {
  document.getElementById("synth-note").textContent = `SAISI AU ${fdate(m.situation)} · ${m.active.toUpperCase()}`;
  document.getElementById("attention").innerHTML = m.synth.attention.map(a => `<li>${esc(a)}</li>`).join("");
  document.querySelector("#risques tbody").innerHTML = m.synth.risques.map(r =>
    `<tr><td><b>${esc(r.id)}</b> ${esc(r.risque)}</td><td class="num">${esc(r.crit)} · ${esc(r.niveau)}</td><td>${esc(r.action)}</td></tr>`).join("");
  document.querySelector("#actions tbody").innerHTML = m.synth.actions.map(a =>
    `<tr><td class="num">${fdate(a.date)}</td><td>${a.statut === "En retard" ? statusHTML("Rouge").replace(">Rouge<", ">En retard<") : esc(a.statut)}</td><td>${esc(a.action)}<br><span class="note">${esc(a.resp)}${a.com ? ` · ${esc(a.com)}` : ""}</span></td></tr>`).join("");
}

function renderReleves(m, sc, d) {
  const names = Object.fromEntries(m.kpis.concat(m.ctx).map(k => [k.code, k.name]));
  const rows = sc.rel.filter(r => r.date <= d).slice().reverse();
  document.querySelector("#releves tbody").innerHTML = rows.map(r => {
    const k = m.kpis.find(x => x.code === r.code);
    return `<tr><td class="num">${fdate(r.date)}</td><td>${esc(r.occ)}</td><td>${esc(names[r.code] || r.code)}</td><td class="num">${esc(fval(r.code, r.val))}</td><td>${k ? statusHTML(kpiStatus(k, r.val)) : ""}</td><td>${esc(r.com || "")}</td></tr>`;
  }).join("");
}

/* -------------------------------------------------------------------------- */
/* Vue Scénarios et résilience                                                 */
/* -------------------------------------------------------------------------- */
function scenarioStats(m, sc) {
  const weeks = m.weeks.filter(w => w <= sc.end);
  const glob = weeks.map(w => situation(m, sc, w).global);
  const firstAlert = weeks.find((w, i) => glob[i] === "Orange" || glob[i] === "Rouge");
  const leviers = sc.hyp.filter(h => h.rub === "Levier");
  const firstLever = firstAlert != null ? leviers.filter(l => l.date >= firstAlert).sort((a, b) => a.date - b.date)[0] : null;
  const issue = Object.fromEntries(sc.hyp.filter(h => h.rub === "Issue").map(h => [h.code, h]));
  const redCounts = weeks.map(w => Object.values(situation(m, sc, w).doms).filter(x => x === "Rouge").length);
  const peak = Math.max(0, ...redCounts);
  return {
    redCounts, peak, peakWeek: peak ? weeks[redCounts.indexOf(peak)] : null, weeksList: weeks,
    vulns: sc.hyp.filter(h => h.rub === "Vulnérabilité"),
    reds: glob.filter(g => g === "Rouge").length, weeks: weeks.length, firstAlert, firstLever,
    leverCost: leviers.reduce((s, l) => s + (l.montant || 0), 0), leviers, issue,
  };
}

function renderScenarios() {
  const m = state.model, d = currentDay();
  const stats = Object.fromEntries(SCENARIOS.map(s => [s, scenarioStats(m, m.scen[s])]));
  const dot = s => `<span class="swatch" style="background:${scenColor(s)}"></span>`;
  const rows = [
    ["Mise en service", s => { const i = stats[s].issue.MES; return i ? fdate(i.date) : ""; }],
    ["Fin du projet", s => { const i = stats[s].issue.FIN, w = i ? Math.round((i.date - m.finRef) / 7) : null; return i ? `${fdate(i.date)} <span class="delta ${w >= 4 ? "bad" : w >= 1 ? "warn" : "good"}">${w > 0 ? `+${w} SEM.` : "À L'HEURE"}</span>` : ""; }],
    ["Coût final", s => { const i = stats[s].issue.COUT; if (!i) return ""; const e = (i.montant - m.cost) / m.cost;
      return `${keur(i.montant)} <span class="delta ${e >= 0.1 ? "bad" : e >= 0.05 ? "warn" : "good"}">${fval("COU-ECA", e)}</span>`; }],
    ["Statut clôture", s => { const i = stats[s].issue.STAT; return i ? chipHTML(i.lib) : ""; }],
    ["Semaines rouges", s => `<b class="big">${stats[s].reds}</b> / ${stats[s].weeks}`],
    ["Pic de tension", s => stats[s].peak ? `<b class="big">${stats[s].peak}</b>/6 <span class="note">${fshort(stats[s].peakWeek)}</span>` : "0/6"],
    ["Vulnérabilités", s => `<b class="big">${stats[s].vulns.length}</b>`],
    ["Réaction", s => { const st = stats[s]; if (st.firstAlert == null) return "—";
      return `alerte ${fshort(st.firstAlert)}${st.firstLever ? ` → levier +${Math.round((st.firstLever.date - st.firstAlert) / 7)} sem.` : ""}`; }],
    ["Solde leviers", s => `${stats[s].leverCost > 0 ? "+" : ""}${keur(stats[s].leverCost)} <span class="note">${stats[s].leviers.length} lev.</span>`],
  ];
  document.getElementById("issues").innerHTML =
    `<thead><tr><th scope="col"></th>${SCENARIOS.map(s => `<th scope="col"><span class="scen">${dot(s)}${esc(s.toUpperCase())}</span></th>`).join("")}</tr></thead>` +
    `<tbody>${rows.map(([label, f]) => `<tr><th scope="row">${label}</th>${SCENARIOS.map(s => `<td>${f(s)}</td>`).join("")}</tr>`).join("")}</tbody>`;

  const b = base(), end = Math.max(...SCENARIOS.map(s => m.scen[s].end));
  const fan = (id, code, fmt, extra) => chart(id).setOption({
    ...b, grid: { ...b.grid, right: extra.endLabels === false ? 16 : 128 },
    xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]), max: ms(end) },
    yAxis: { ...b.yAxis, type: "value", ...(extra.y || {}), axisLabel: { ...b.yAxis.axisLabel, formatter: v => fmt(v) } },
    tooltip: { ...b.tooltip, formatter: axisTooltip(v => fmt(v)) },
    legend: { ...b.legend, data: SCENARIOS },
    series: [
      ...(extra.pre || []),
      ...SCENARIOS.map(s => lineSeries(s, series(m.scen[s], code), scenColor(s), {
        lineStyle: { width: s === state.scenario ? 3 : 2, color: scenColor(s) },
        endLabel: { show: extra.endLabels !== false, formatter: p => `${s} ${fmt(p.value[1])}`, color: css("--ink"), fontSize: 11 },
        labelLayout: { moveOverlap: "shiftY" },
        markLine: s === SCENARIOS[0] ? { ...situationLine(d), ...(extra.markLine ? { data: [...situationLine(d).data, ...extra.markLine] } : {}) } : undefined,
      })),
    ],
  }, true);
  fan("chart-fan-av", "CTX-AVR", v => pf0.format(v), {
    y: { min: 0, max: 1 }, endLabels: false,
    pre: [lineSeries("Planifié", series(m.scen.Favorable, "CTX-AVP"), css("--planned"), { tooltip: { show: false } })],
  });
  const refLine = (y, label, color, position = "insideStartTop") => ({ yAxis: y, label: { formatter: label, color, fontSize: 11, position }, lineStyle: { color, width: 1, type: "solid" } });
  fan("chart-fan-eac", "CTX-EAC", v => keur(v), {
    y: { min: v => Math.floor(Math.min(v.min, m.cost) / 10000) * 10000 - 10000, max: v => Math.ceil(v.max / 10000) * 10000 + 5000 },
    markLine: [refLine(m.cost, `Coût prévu ${keur(m.cost)}`, css("--muted"), "insideStartBottom"), refLine(m.budget, `Enveloppe ${keur(m.budget)}`, css("--st-rouge"))],
  });

  // Frises globales empilées
  const cols = m.weeks.filter(w => w <= end);
  const data = [];
  SCENARIOS.forEach((s, y) => cols.forEach((w, x) => {
    const sc = m.scen[s];
    const g = w <= sc.end ? situation(m, sc, w).global : null;
    data.push({ value: [x, SCENARIOS.length - 1 - y, RANK[g] || 0], status: g || "", itemStyle: { color: w <= sc.end ? heat(g) : css("--heat-future"), borderColor: css("--surface"), borderWidth: 1, borderRadius: 0 } });
  }));
  chart("chart-frises").setOption({
    ...b, grid: { left: 104, right: 8, top: 8, bottom: 24, containLabel: false },
    tooltip: { ...b.tooltip, trigger: "item", formatter: p => {
      const s = SCENARIOS[SCENARIOS.length - 1 - p.value[1]], w = cols[p.value[0]], sc = m.scen[s];
      if (w > sc.end) return `${esc(s)} : projet clôturé le ${fdate(sc.end)}`;
      const fact = weekFact(sc, w);
      return `<div style="max-width:300px;white-space:normal"><div style="color:${css("--muted")}">${isoWeek(w)} · ${fdate(w)}</div><b>${esc(s)} : ${esc(p.data.status || "Non mesuré")}</b>${fact ? `<div style="margin-top:4px">${fact}</div>` : ""}</div>`;
    } },
    xAxis: { type: "category", data: cols.map(isoWeek), axisLine: { show: false }, axisTick: { show: false }, axisLabel: { color: css("--muted"), fontSize: 10, hideOverlap: true } },
    yAxis: { type: "category", data: [...SCENARIOS].reverse(), axisLine: { show: false }, axisTick: { show: false }, axisLabel: { color: css("--ink-2"), fontSize: 10, width: 96, overflow: "truncate" } },
    series: [{ type: "heatmap", data, emphasis: { itemStyle: { borderColor: css("--ink"), borderWidth: 2 } } }],
  }, true);

  // Indice de tension
  chart("chart-tension").setOption({
    ...b, grid: { ...b.grid, right: 16 },
    xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]), max: ms(end) },
    yAxis: { ...b.yAxis, type: "value", min: 0, max: 6, interval: 1 },
    tooltip: { ...b.tooltip, formatter: axisTooltip(v => `${v} sur 6`) },
    legend: { ...b.legend, data: SCENARIOS },
    series: SCENARIOS.map((s, i) => lineSeries(s, stats[s].weeksList.map((w, j) => [ms(w), stats[s].redCounts[j]]), scenColor(s), {
      step: "end", lineStyle: { width: s === state.scenario ? 3 : 2, color: scenColor(s) },
      areaStyle: s === "Tensions" ? { color: scenColor(s), opacity: 0.12 } : undefined,
      markLine: i === 0 ? situationLine(d) : undefined,
      markPoint: stats[s].peak >= 4 ? { symbol: "circle", symbolSize: 10, itemStyle: { color: scenColor(s), borderColor: css("--surface"), borderWidth: 2 },
        label: { show: true, position: "top", formatter: `${s} : ${stats[s].peak}/6 le ${fshort(stats[s].peakWeek)}`, color: css("--ink"), fontSize: 11 },
        data: [{ coord: [ms(stats[s].peakWeek), stats[s].peak] }] } : undefined,
    })),
  }, true);

  // Chocs et leviers
  const maxAmt = Math.max(1, ...SCENARIOS.flatMap(s => m.scen[s].hyp.map(h => Math.abs(h.montant || 0))));
  const pts = kind => SCENARIOS.flatMap((s, i) => m.scen[s].hyp.filter(h => h.rub === kind && h.date != null).map(h => ({
    value: [ms(h.date), SCENARIOS.length - 1 - i], h, s,
    symbolSize: kind === "Choc" ? 14 : 10 + 22 * Math.sqrt(Math.abs(h.montant || 0) / maxAmt),
  })));
  chart("chart-leviers").setOption({
    ...b, grid: { left: 104, right: 16, top: 16, bottom: 28, containLabel: false }, legend: { show: false },
    tooltip: { ...b.tooltip, trigger: "item", formatter: p => {
      const { h, s } = p.data;
      return `<div style="max-width:300px;white-space:normal"><div style="color:${css("--muted")}">${esc(s)} · ${fdate(h.date)} · ${esc(h.rub)}${h.code ? ` ${esc(h.code)}` : ""}</div><b>${esc(h.lib)}</b>${h.montant ? `<div>Montant : ${h.montant > 0 ? "+" : ""}${eur(h.montant)}</div>` : ""}${h.effet ? `<div>${esc(h.effet)}</div>` : ""}</div>`;
    } },
    xAxis: { ...b.xAxisTime, min: ms(m.weeks[0]), max: ms(end) },
    yAxis: { type: "category", data: [...SCENARIOS].reverse(), axisLine: { show: false }, axisTick: { show: false }, splitLine: { show: true, lineStyle: { color: css("--grid") } }, axisLabel: { color: css("--ink-2"), fontSize: 10, width: 96, overflow: "truncate" } },
    series: [
      { name: "Choc", type: "scatter", symbol: "triangle", data: pts("Choc"), itemStyle: { color: css("--choc"), borderColor: css("--surface"), borderWidth: 2 } },
      { name: "Levier", type: "scatter", symbol: "circle", data: pts("Levier"), itemStyle: { color: css("--levier"), opacity: 0.85, borderColor: css("--surface"), borderWidth: 2 } },
      { type: "line", data: [], markLine: situationLine(d) },
    ],
  }, true);
  document.getElementById("legend-leviers").innerHTML =
    `<span><svg viewBox="0 0 14 14" aria-hidden="true"><path d="M7 1.5l6 11H1z" fill="${css("--choc")}"/></svg>Choc</span>` +
    `<span><svg viewBox="0 0 14 14" aria-hidden="true"><circle cx="7" cy="7" r="5" fill="${css("--levier")}"/></svg>Levier (taille = montant)</span>`;

  document.getElementById("recits").innerHTML = SCENARIOS.map(s => {
    const sc = m.scen[s], recit = sc.hyp.find(h => h.rub === "Récit");
    const items = sc.hyp.filter(h => h.rub === "Levier").map(h => `<li title="${esc(h.effet || "")}">${fshort(h.date)} ${esc(h.lib)}${h.montant ? ` <b>${h.montant > 0 ? "+" : ""}${keur(h.montant)}</b>` : ""}</li>`).join("");
    const vulns = sc.hyp.filter(h => h.rub === "Vulnérabilité").map(h => `<li title="${esc(h.effet || "")}">${esc(h.lib)}</li>`).join("");
    return `<article class="recit" style="--c:${scenColor(s)}"><h3>${esc(s.toUpperCase())}</h3><p>${esc(recit ? recit.lib : "")}</p>
      ${vulns ? `<p class="tag vuln">Vulnérabilités · ${sc.hyp.filter(h => h.rub === "Vulnérabilité").length}</p><ul>${vulns}</ul>` : `<p class="tag">Aucune vulnérabilité révélée</p>`}
      <p class="tag">Leviers</p><ul>${items}</ul></article>`;
  }).join("");
}

/* -------------------------------------------------------------------------- */
/* Commandes                                                                   */
/* -------------------------------------------------------------------------- */
function render() {
  const out = document.getElementById("date-out"), d = currentDay();
  out.textContent = `${isoWeek(d)} · ${fdate(d)}`;
  document.querySelectorAll("#scenarios button").forEach(b => b.setAttribute("aria-checked", String(b.dataset.s === state.scenario)));
  if (state.view === "situation") renderSituation(); else renderScenarios();
}

function setupControls() {
  const m = state.model;
  document.getElementById("scenarios").innerHTML = SCENARIOS.map(s =>
    `<button type="button" role="radio" data-s="${esc(s)}" aria-checked="false"><span class="swatch" style="background:var(${SCEN_VAR[s]})"></span>${esc(s)}</button>`).join("");
  document.getElementById("scenarios").addEventListener("click", e => {
    const btn = e.target.closest("button[data-s]");
    if (btn) { state.scenario = btn.dataset.s; render(); }
  });
  const slider = document.getElementById("date");
  slider.max = String(m.weeks.length - 1);
  const sitIndex = () => { let i = m.weeks.findIndex(w => w >= m.situation); return i < 0 ? m.weeks.length - 1 : i; };
  state.dayIndex = sitIndex();
  slider.value = String(state.dayIndex);
  slider.addEventListener("input", () => { state.dayIndex = +slider.value; render(); });
  document.getElementById("reset-date").addEventListener("click", () => { stop(); state.dayIndex = sitIndex(); slider.value = String(state.dayIndex); render(); });
  const play = document.getElementById("play");
  const stop = () => { if (state.playing) { clearInterval(state.playing); state.playing = null; play.textContent = "▶"; play.setAttribute("aria-label", "Rejouer le projet semaine après semaine"); } };
  play.addEventListener("click", () => {
    if (state.playing) return stop();
    if (state.dayIndex >= m.weeks.length - 1) state.dayIndex = 0;
    play.textContent = "❚❚"; play.setAttribute("aria-label", "Mettre en pause");
    state.playing = setInterval(() => {
      state.dayIndex++; slider.value = String(state.dayIndex); render();
      if (state.dayIndex >= m.weeks.length - 1) stop();
    }, 650);
  });
  document.querySelectorAll('[role="tab"]').forEach(tab => tab.addEventListener("click", () => {
    state.view = tab.id === "tab-situation" ? "situation" : "scenarios";
    document.querySelectorAll('[role="tab"]').forEach(t => t.setAttribute("aria-selected", String(t === tab)));
    document.getElementById("view-situation").hidden = state.view !== "situation";
    document.getElementById("view-scenarios").hidden = state.view !== "scenarios";
    render();
    Object.values(state.charts).forEach(c => c.resize());
  }));
}

function setupTheme() {
  const btn = document.getElementById("theme"), labels = { light: "CLAIR", dark: "SOMBRE" };
  let mode = "light";
  try { mode = localStorage.getItem("tdb-theme") === "dark" ? "dark" : "light"; } catch (e) { /* stockage indisponible */ }
  const forced = new URLSearchParams(location.search).get("theme");
  if (forced in labels) mode = forced;
  const apply = () => {
    document.documentElement.setAttribute("data-theme", mode);
    btn.textContent = labels[mode];
    if (state.model) render();
  };
  btn.addEventListener("click", () => {
    mode = mode === "light" ? "dark" : "light";
    try { localStorage.setItem("tdb-theme", mode); } catch (e) { /* stockage indisponible */ }
    apply();
  });
  apply();
}

async function main() {
  setupTheme();
  const source = document.getElementById("source");
  let sources;
  try {
    sources = await fetch("data/sources.json", { cache: "no-store" }).then(r => r.json());
  } catch (e) {
    document.getElementById("error").hidden = false;
    document.getElementById("error").textContent = "Impossible de lire la configuration des sources (data/sources.json).";
    return;
  }
  const sheetUrl = `https://docs.google.com/spreadsheets/d/${sources.sheetId}/edit`;
  try {
    const res = await fetchLive(sources);
    state.model = buildModel(res);
    source.className = "source live";
    source.innerHTML = `EN DIRECT · <a href="${sheetUrl}" target="_blank" rel="noopener">D6</a> · ${new Date().toLocaleString("fr-FR", { dateStyle: "short", timeStyle: "short" })}`;
  } catch (live) {
    console.warn("Lecture en direct impossible, copie de secours utilisée :", live);
    try {
      const snap = await fetch("data/snapshot.json", { cache: "no-store" }).then(r => r.json());
      state.model = buildModel(snap.responses);
      source.className = "source snapshot";
      source.innerHTML = `COPIE · <a href="${sheetUrl}" target="_blank" rel="noopener">D6</a> · ${new Date(snap.generated).toLocaleString("fr-FR", { dateStyle: "short", timeStyle: "short" })}`;
      source.title = live.message;
    } catch (e) {
      document.getElementById("error").hidden = false;
      document.getElementById("error").textContent = `Données indisponibles : ${live.message} ; copie de secours : ${e.message}`;
      source.textContent = "Aucune donnée";
      return;
    }
  }
  state.scenario = state.model.active;
  setupControls();
  if (location.hash === "#scenarios") document.getElementById("tab-scenarios").click(); else render();
  window.addEventListener("resize", () => Object.values(state.charts).forEach(c => c.resize()));
}

document.addEventListener("DOMContentLoaded", main);
