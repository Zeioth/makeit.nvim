# [Makeit.nvim](https://github.com/Zeioth/makeit.nvim)
Detect the project Makefile and show all options on Telescope so the user can select them visually. It is a user friendly replacement for `:make myoption`

## When should I use this plugin?
For simple scenarios, or border cases where [compiler.nvim](https://github.com/Zeioth/compiler.nvim) doesn't suit your needs.

## How to install
lazy.nvim package manager
```lua
{ -- This plugin
  "Zeioth/makeit.nvim",
  cmd = {"MakeitOpen", "MakeitToggleResults", "MakeitRedo"},
  dependencies = { "stevearc/overseer.nvim" },
  opts = {},
},
{ -- The task runner we use
  "stevearc/overseer.nvim",
  commit = "3047ede61cc1308069ad1184c0d447ebee92d749",
  cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  opts = {
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 25,
      default_detail = 1,
      bindings = { ["q"] = function() vim.cmd("OverseerClose") end },
    },
  },
},
```

## Commands

| Command | Description|
|--|--|
| `:MakeitOpen` | Shows the adecuated compiler for your buffer's filetype. |
| `:MakeitToggleResults` | Open or close the compiler results. |
| `:MakeitRedo` | Redo the last selected option. |
| `:MakeitStop` | Dispose all tasks. |
