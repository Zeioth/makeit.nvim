# [Makeit.nvim](https://github.com/Zeioth/makeit.nvim)
List all of your `Makefile` options on Telescope. Then it run the selected option asynchronously with overseer.

## When should I use this plugin?
In scenarios where you prefer to manually write your own commands to build and run your project, instead of using [compiler.nvim](https://github.com/Zeioth/compiler.nvim).

## Screenshots
[Makeit.nvim](https://github.com/Zeioth/makeit.nvim) list the options defined on your project `Makefile`
![screenshot_2023-09-01_10-20-30_465268693](https://github.com/Zeioth/makeit.nvim/assets/3357792/29a373c1-6d19-49fb-95a6-f350a16b1c41)
By selecting an option, we can see the result without in a clear way.
![screenshot_2023-09-01_10-20-37_056327408](https://github.com/Zeioth/makeit.nvim/assets/3357792/5041f518-05d3-4458-8999-d8d274a4b3b2)


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
| `:MakeitOpen` | Shows all the options defined in your Makefile. |
| `:MakeitToggleResults` | Open or close the compiler results. |
| `:MakeitRedo` | Redo the last selected option. |
| `:MakeitStop` | Dispose all tasks. |

## FAQ

* **Do this plugin support any operative system?**
YES: as long as you are can run the commands `make` and `echo` on your terminal, [makeit.nvim](https://github.com/Zeioth/makeit.nvim) will be able to use them.
