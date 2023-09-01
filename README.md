# [Makeit.nvim](https://github.com/Zeioth/makeit.nvim)
This plugin list all of your `Makefile` options on Telescope. Then it runs the selected option with overseer.

## When should I use this plugin?
In scenarios where you prefer to manually write your own commands to build and run your project, instead of using [compiler.nvim](https://github.com/Zeioth/compiler.nvim).

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
