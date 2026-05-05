Carsten, I’ve got you — here’s the **Mini.pick Lua‑pattern cheat sheet** you can actually _use while searching_, not the usual abstract regex lecture. This is tuned for your workflow: fast, practical, and Rust/Lua‑friendly.

---

# 🎯 **Mini.pick Search Cheat Sheet (Lua Patterns)**

### _Your quick, reliable guide to escaping, matching, and searching like a pro._

---

## 🔥 **1. Literal search (the thing you’ll do 90% of the time)**

Lua patterns treat these characters as _magic_:

```
( ) . % + - * ? [ ] ^ $
```

To search for them literally, prefix with `%`.

### Example:

Search for:

```
require("myawsomeplugin")
```

Use:

```
require%("%myawsomeplugin%"%)
```

---

## 🔧 **2. Escaping special characters**

|Character|Escape as|Meaning|
|---|---|---|
|`(`|`%(`|literal `(`|
|`)`|`%)`|literal `)`|
|`.`|`%.`|literal `.`|
|`%`|`%%`|literal `%`|
|`+`|`%+`|literal `+`|
|`-`|`%-`|literal `-`|
|`*`|`%*`|literal `*`|
|`?`|`%?`|literal `?`|
|`[`|`%[`|literal `[`|
|`]`|`%]`|literal `]`|
|`^`|`%^`|literal `^`|
|`$`|`%$`|literal `$`|

If in doubt: **escape it**.

---

## 🔍 **3. Useful pattern tokens**

|Token|Meaning|Example|
|---|---|---|
|`%a`|letter|`%a+` → words|
|`%d`|digit|`%d%d%d` → 3 digits|
|`%w`|alphanumeric|`%w+`|
|`%s`|whitespace|`%s+`|
|`%p`|punctuation|`%p+`|
|`.`|any character|`a.b` → `acb`, `a_b`|

---

## 📏 **4. Quantifiers**

|Symbol|Meaning|
|---|---|
|`*`|zero or more|
|`+`|one or more|
|`?`|zero or one|

Example: match `fn foo`:

```
^fn%s+%w+
```

---

## 🎯 **5. Anchors**

|Symbol|Meaning|
|---|---|
|`^`|start of string|
|`$`|end of string|

Examples:

```
^pub
%.rs$
```

---

## 🧠 **6. Practical patterns you’ll actually use**

### Find Rust function definitions

```
^fn%s+%w+
```

### Find struct definitions

```
^struct%s+%w+
```

### Find enum variants

```
%u%w*  -- uppercase start
```

### Find snake_case identifiers

```
%l+_%l+
```

### Find TODO comments

```
TODO
```

### Find all `.rs` files

```
%.rs$
```

### Find paths with `/src/`

```
/src/
```

---

## ⚡ **7. Fuzzy matching (Mini.pick’s secret weapon)**

If you don’t use pattern symbols, Mini.pick switches to fuzzy mode.

```
mfn
```

matches:

- `main_function_name`
    
- `my_file_name`
    
- `module/fn.rs`
    

It’s surprisingly good.

---

## 🧩 **8. Searching for literal strings (your rule of thumb)**

When you want to search for something _exactly as written_:

1. Identify special characters
    
2. Escape each with `%`
    
3. Keep everything else unchanged
    

Example:

Search for:

```
foo.bar(baz)
```

Pattern:

```
foo%.bar%(baz%)
```

---

If you want, I can help you build a **Rust‑specific Mini.pick search pack** — patterns for traits, impl blocks, lifetimes, generics, modules, and more.