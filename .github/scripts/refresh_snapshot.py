"""Rafraîchit la copie de secours du tableau de bord (site/data/snapshot.json) depuis le classeur D6 publié.

Interroge l'API gviz de Google Sheets pour chaque plage de site/data/sources.json et conserve les réponses
brutes : la page web les lit avec le même code que les réponses en direct.
"""
import datetime as dt
import json
import sys
import urllib.parse
import urllib.request
from pathlib import Path

DATA = Path(__file__).resolve().parents[2] / "site" / "data"


def main():
    sources = json.loads((DATA / "sources.json").read_text(encoding="utf-8"))
    responses = {}
    for key, (sheet, rng) in sources["queries"].items():
        query = urllib.parse.urlencode({"tqx": "out:json", "headers": "0", "sheet": sheet, "range": rng})
        url = f"https://docs.google.com/spreadsheets/d/{sources['sheetId']}/gviz/tq?{query}"
        with urllib.request.urlopen(url, timeout=30) as resp:
            text = resp.read().decode("utf-8")
        if '"status":"ok"' not in text:
            sys.exit(f"Réponse en erreur pour {key} ({sheet}!{rng}) : {text[:300]}")
        responses[key] = text
    # gviz répond « ok » avec une table vide pour un onglet absent : on vérifie la structure attendue
    missing = [k for k in sources["queries"] if k.startswith("rel:") and '"CTX-AVR"' not in responses[k]]
    if "Scénario actif" not in responses["params"] or missing:
        print(f"Classeur publié dans une ancienne version (onglets manquants : {missing or 'paramètres'}) : copie conservée.")
        return
    snapshot = {"generated": dt.datetime.now(dt.timezone.utc).isoformat(timespec="seconds"), "origin": "gviz",
                "responses": responses}
    (DATA / "snapshot.json").write_text(json.dumps(snapshot, ensure_ascii=False), encoding="utf-8")
    print(f"{len(responses)} plages enregistrées dans {DATA / 'snapshot.json'}")


if __name__ == "__main__":
    main()
