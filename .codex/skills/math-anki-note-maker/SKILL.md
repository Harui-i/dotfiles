---
name: math-anki-note-maker
description: Create university mathematics Anki notes from textbook photos, OCR text, handwritten excerpts, or user-provided theorem/definition material. Use when Codex is asked to turn math definitions, theorems, axioms, examples, or textbook images into Anki notes using the user's existing "大学数学用ノートタイプ", choose or create an appropriate "大学数学::..." deck, draft notes for review, or add reviewed notes through AnkiConnect.
---

# Math Anki Note Maker

## Core Rule

Preserve the textbook's notation and wording as much as possible. Do not invent missing hypotheses, definitions, theorem names, or symbols. Mark uncertain OCR/image readings with `[要確認: ...]` and ask for clarification when the mathematical meaning depends on the unclear part.

Each generated card must be understandable from the front side shown to the Anki user. For the user's math note type, the front side renders `表面` as the shared context and `カードN-表` as the actual question; `裏面`, `カードN-裏`, and `メモ` appear only after revealing the answer. Therefore, any symbols, variables, hypotheses, ambient spaces, or standing assumptions used in `カードN-表` must appear in `表面` or in `カードN-表` itself. Do not use a symbol on the card front if it is defined only in `裏面`.

## Workflow

1. Gather context from the user input:
   - image(s), OCR text, or typed excerpt
   - desired deck, subject, book/title, page, chapter/section, and user request if provided
2. If an image is attached, inspect it visually before drafting. Extract only what is legible; do not silently normalize notation.
3. Choose the deck:
   - Use an explicitly requested deck when present.
   - Otherwise infer a `大学数学::...` deck from the topic, matching existing deck names when possible.
   - If no suitable deck exists, create a specific subdeck under `大学数学`, such as `大学数学::解析学::ノルム空間`.
4. Before drafting, inspect a few existing notes in the target deck when AnkiConnect is available. Match the user's established field conventions, especially the `表面` format, tags, source placement, and whether questions live in `表面` or `カード1-表`.
5. Draft notes first. Do not add to Anki until the user explicitly confirms.
6. Use the existing note type `大学数学用ノートタイプ`.
   - This math note type already creates up to four prompt/answer cards from `カード1` ... `カード4`.
   - Do not switch math notes to reversible note types such as `Basic (and reversed card)` or `基本 (裏表反転カード付き)` unless the user explicitly asks for reversible math cards.
7. Before presenting or adding notes, audit every non-empty `カードN-表`: the rendered front is `表面` + `カードN-表`, so check that all notation and assumptions needed to answer it are visible there.
8. After confirmation, add notes through AnkiConnect, then report the note IDs and any warnings.

## Field Mapping

Use these fields exactly:

- `表面`: follow the target deck's existing convention. In the user's topology notes this is often source/context such as `定義19.16<br>\(X\): 位相空間, \(A \subseteq X\) とする。`, not the question itself.
- `裏面`: exact definition/theorem statement or answer
- `カード1-表` / `カード1-裏`: first actual prompt and answer when `表面` is used for source/context. Use `裏面参照` when the answer is exactly the main back side.
- `カード2-表` / `カード2-裏`: conclusion, notation meaning, or second supporting question
- `カード3-表` / `カード3-裏`: example, non-example, equivalent formulation, or caution
- `カード4-表` / `カード4-裏`: proof idea, use case, related theorem, or remaining caution
- `メモ`: source, page, chapter, user notes, OCR uncertainty, and tags-worthy context

Keep each note focused on one concept. Split separate definitions, theorem statements, and examples into separate notes unless the user asks for a compact combined note.

When a note uses parameters or standing notation across several cards, put the shared setup in `表面`, for example `\(A\): \(m\times n\) 行列, \(\operatorname{rank}(A)=r\), \(A:\mathbb{R}^n\to\mathbb{R}^m\)`. Keep card-specific prompts in `カードN-表`. Avoid hiding essential setup only in `裏面`; that field is a summary/back-side reference, not front-side context.

## Draft Format

Present a review table or compact JSON-like list before adding. Include:

- deck name
- note type
- all non-empty fields
- source info
- uncertainty warnings

Use Japanese for note text unless the source is explicitly in another language or the user requests otherwise.

## AnkiConnect

Use `scripts/anki_connect.py` for deck/model discovery and note creation when Anki is running with AnkiConnect enabled on `http://127.0.0.1:8765`.

Common commands:

```bash
python3 scripts/anki_connect.py version
python3 scripts/anki_connect.py deck-names
python3 scripts/anki_connect.py model-fields "大学数学用ノートタイプ"
python3 scripts/anki_connect.py ensure-deck "大学数学::位相空間論"
python3 scripts/anki_connect.py add-notes draft.json
```

The `add-notes` command expects JSON:

```json
[
  {
    "deckName": "大学数学::位相空間論",
    "modelName": "大学数学用ノートタイプ",
    "fields": {
      "表面": "定義19.16<br>\\(X\\): 位相空間とする。",
      "裏面": "...",
      "カード1-表": "\\(X\\) が可分であることの定義は？",
      "カード1-裏": "裏面参照",
      "メモ": "出典: 書名 p.42"
    },
    "tags": ["math", "codex"]
  }
]
```

## References

Read `references/note-design.md` when deciding how to split mathematical material into effective cards.
