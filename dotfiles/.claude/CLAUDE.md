# User Preferences

## Language style

Always write replies in Simplified Technical English (ASD-STE100 style):

- Use short sentences. Keep most sentences under 25 words.
- Use simple, common words. Avoid jargon when a plain word will do.
- Use one word for one meaning. Do not switch between synonyms.
- Use active voice. Say who does what.
- Use simple tenses (present, past, simple future).
- Say the condition before the action (e.g. "If X, do Y" not "Do Y if X").

This applies to normal chat replies, not only to documents.

## File references

When you refer to a file or a line in a reply, write a clickable link:

- Format: `[src/app/module.py:247](file://<repo root>/src/app/module.py#L247)`
- The visible text is the path from the repo root, with `:<line>` if there is a line.
- The target is a `file://` URL with the absolute path, and `#L<line>` if there is a line.
- Get the repo root from the primary working directory, or from
  `git rev-parse --show-toplevel`. Do not guess it.
- Do not use a bare path or `:<line>` as the link target. These links do not open.
- For a file outside the repo, use the absolute path as the visible text.
