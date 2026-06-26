#!/usr/bin/env python3
import argparse
import json
import sys
import urllib.request


ANKI_CONNECT_URL = "http://127.0.0.1:8765"


def request(action, params=None):
    payload = json.dumps({
        "action": action,
        "version": 6,
        "params": params or {},
    }).encode("utf-8")
    req = urllib.request.Request(
        ANKI_CONNECT_URL,
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=20) as resp:
        data = json.loads(resp.read().decode("utf-8"))
    if data.get("error") is not None:
        raise RuntimeError(data["error"])
    return data.get("result")


def print_json(value):
    print(json.dumps(value, ensure_ascii=False, indent=2))


def cmd_version(_args):
    print_json(request("version"))


def cmd_deck_names(_args):
    print_json(request("deckNames"))


def cmd_model_names(_args):
    print_json(request("modelNames"))


def cmd_model_fields(args):
    print_json(request("modelFieldNames", {"modelName": args.model_name}))


def cmd_ensure_deck(args):
    request("createDeck", {"deck": args.deck_name})
    print_json({"deckName": args.deck_name})


def normalize_note(note):
    note = dict(note)
    note.setdefault("modelName", "大学数学用ノートタイプ")
    note.setdefault("tags", ["math", "codex"])
    note.setdefault("options", {"allowDuplicate": False})
    note.setdefault("fields", {})
    return note


def cmd_add_notes(args):
    with open(args.json_file, "r", encoding="utf-8") as f:
        notes = json.load(f)
    if isinstance(notes, dict):
        notes = [notes]
    notes = [normalize_note(note) for note in notes]
    deck_names = sorted({note["deckName"] for note in notes})
    for deck_name in deck_names:
        request("createDeck", {"deck": deck_name})
    result = request("addNotes", {"notes": notes})
    print_json({"noteIds": result})


def main():
    parser = argparse.ArgumentParser(description="Small AnkiConnect helper for math Anki notes.")
    sub = parser.add_subparsers(dest="command", required=True)

    p = sub.add_parser("version")
    p.set_defaults(func=cmd_version)

    p = sub.add_parser("deck-names")
    p.set_defaults(func=cmd_deck_names)

    p = sub.add_parser("model-names")
    p.set_defaults(func=cmd_model_names)

    p = sub.add_parser("model-fields")
    p.add_argument("model_name")
    p.set_defaults(func=cmd_model_fields)

    p = sub.add_parser("ensure-deck")
    p.add_argument("deck_name")
    p.set_defaults(func=cmd_ensure_deck)

    p = sub.add_parser("add-notes")
    p.add_argument("json_file")
    p.set_defaults(func=cmd_add_notes)

    args = parser.parse_args()
    try:
        args.func(args)
    except Exception as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
