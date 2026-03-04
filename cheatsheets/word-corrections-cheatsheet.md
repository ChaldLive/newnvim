# Neovim Spell‑Checking Cheatsheet

A compact reference for navigating, correcting, and managing spelling inside Neovim.

---

## 1. Navigation

| Action                   | Command | Description                                  |
| ------------------------ | ------- | -------------------------------------------- |
| Next misspelled word     | `]s`    | Jump forward to the next spelling error      |
| Previous misspelled word | `[s`    | Jump backward to the previous spelling error |

---

## 2. Suggestions & Corrections

| Action                    | Command    | Description                                              |
| ------------------------- | ---------- | -------------------------------------------------------- |
| Show spelling suggestions | `z=`       | Open a list of suggestions for the word under the cursor |
| Choose a suggestion       | `<number>` | Apply the selected suggestion from the list              |

---

## 3. Dictionary Management

| Action                      | Command | Description                                          |
| --------------------------- | ------- | ---------------------------------------------------- |
| Add word to dictionary      | `zg`    | Mark word as _good_ (add to your personal spellfile) |
| Remove word from dictionary | `zw`    | Mark word as _wrong_ (remove from spellfile)         |
| Mark word as rare           | `zr`    | Mark as rare but not incorrect                       |
| Mark word as local          | `zl`    | Mark as valid only in this buffer                    |

---

## 4. Spellfile Details

| Item                 | Value / Command                               | Description                     |
| -------------------- | --------------------------------------------- | ------------------------------- |
| Default spellfile    | `~/.config/nvim/spell/en.utf-8.add`           | Where custom words are stored   |
| Rebuild spellfile    | `:mkspell! ~/.config/nvim/spell/en.utf-8.add` | Reload after manual edits       |
| Set custom spellfile | `vim.opt.spellfile = "path/to/file.add"`      | Define your own dictionary file |

---

## 5. Useful Options (especially for Markdown)

| Setting                               | Description                                                   |
| ------------------------------------- | ------------------------------------------------------------- |
| `setlocal spell`                      | Enable spellchecking                                          |
| `setlocal spelloptions=noplainbuffer` | Prevent escaping Markdown formatting (`**`, `_`, etc.)        |
| `setlocal spellcapcheck=`             | Disable capital‑letter heuristics (good for creative writing) |
| `setlocal wrap`                       | Soft-wrap long lines for easier reading                       |
| `setlocal linebreak`                  | Wrap at word boundaries instead of mid‑word                   |
| `setlocal conceallevel=2`             | Hide Markdown markers for a cleaner writing view              |
