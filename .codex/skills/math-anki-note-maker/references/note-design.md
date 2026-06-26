# Math Anki Note Design

## Priorities

1. Exact notation from the source
2. Consistency with existing notes in the target deck
3. Minimal, testable prompts
4. Clear hypotheses and conclusions
5. Source traceability
6. Explicit uncertainty

## Split Rules

- One definition -> one note.
- One theorem -> one note for the statement, plus optional supporting cards for hypotheses, conclusion, and use.
- One axiom system -> one note for the full system, plus supporting cards for each axiom if needed.
- One example or counterexample -> one note only if it is important or easy to confuse.
- A long proof -> usually do not memorize line-by-line. Prefer proof idea, key lemma, and the step where a hypothesis is used.

## Prompt Patterns

Always prefer the field pattern already used in the target deck. If AnkiConnect is available, inspect several existing notes before drafting. Do not assume `表面` is the question field.

For the user's existing `大学数学::位相空間論` notes, definitions commonly use:

- `表面`: definition number and hypotheses/context, e.g. `定義19.16<br>\(X\): 位相空間, \(A \subseteq X\) とする。`
- `裏面`: textbook definition statement
- `カード1-表`: actual question, e.g. `部分集合 \(A\) が \(X\) で稠密であることの定義は？`
- `カード1-裏`: `裏面参照` when the answer is exactly the back side
- `カード2` and later: notation checks, equivalent formulations, examples, or cautions

Definition:

- `表面`: source/context if that is the deck convention; otherwise `<term>の定義を述べよ。`
- `裏面`: textbook definition
- `カード1`: actual definition question, notation, or required conditions
- `カード2`: typical example or non-example

Theorem:

- `表面`: source/context if that is the deck convention; otherwise `<theorem name/topic>の主張を述べよ。`
- `裏面`: full statement
- `カード1`: hypotheses
- `カード2`: conclusion
- `カード3`: where/why it is used
- `カード4`: proof idea if useful

Axiom:

- `表面`: source/context if that is the deck convention; otherwise `<structure>の公理を述べよ。`
- `裏面`: full axiom list
- supporting cards: individual axioms or symbols

Notation:

- `表面`: `記号 <symbol> の意味は？`
- `裏面`: exact meaning in this text
- `メモ`: local convention and source

## Deck Selection Heuristics

Prefer existing decks under `大学数学`.

- topology, open sets, compactness, continuity -> `大学数学::位相空間論`
- normed/vector spaces, metric, convergence -> `大学数学::解析学::ノルム空間`
- measure, measurable sets, integration -> `大学数学::測度論`
- matrices, vector spaces, linear maps -> `大学数学::線形代数`
- complex functions, holomorphic, residues -> existing complex analysis deck
- ODE -> existing ODE deck
- number theory -> `大学数学::整数論`
- algorithms -> existing algorithm decks

If uncertain, use `大学数学` and ask whether to create a subdeck.

## Safety

- Never add cards when the source text is mathematically ambiguous.
- Never silently replace a symbol with a standard alternative.
- Never add external facts unless the user requests supplementation; if added, label them as outside-source notes.
- Keep copyrighted textbook text limited to what is necessary for the user's private note-making workflow.
