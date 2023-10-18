# You can [makeit.nvim](https://github.com/Zeioth/makeit.nvim) ❤️

[Makeit.nvim](https://github.com/Zeioth/makeit.nvim) lists the options defined on your project `Makefile`
![screenshot_2023-09-01_10-20-30_465268693](https://github.com/Zeioth/makeit.nvim/assets/3357792/29a373c1-6d19-49fb-95a6-f350a16b1c41)

After selecting an option, you can visualize the result
![screenshot_2023-09-01_10-20-37_056327408](https://github.com/Zeioth/makeit.nvim/assets/3357792/5041f518-05d3-4458-8999-d8d274a4b3b2)


<div align="center">
  <a href="https://discord.gg/ymcMaSnq7d" rel="nofollow">
      <img src="https://img.shields.io/discord/1121138836525813760?color=azure&labelColor=6DC2A4&logo=discord&logoColor=black&label=Join the discord server&style=for-the-badge" data-canonical-src="https://img.shields.io/discord/1121138836525813760">
    </a>
</div>

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
  cmd = {"MakeitOpen", "MakeitToggleResults", "MakeitRedo"},
  opts = {
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 25,
      default_detail = 1,
    },
  },
},
```

## Commands

| Command | Description|
|--|--|
| `:MakeitOpen` | Shows all the options defined in your Makefile. |
| `:MakeitToggleResults` | Open or close the results of running your makefile. |
| `:MakeitRedo` | Redo the last selected option. |
| `:MakeitStop` | Dispose all tasks. |

## FAQ

* **Do this plugin support any operative system?**
YES: As long as you can run the commands `make` and `echo` on your terminal, [makeit.nvim](https://github.com/Zeioth/makeit.nvim) will be able to use them.

## Other projects from the same author
* [NormalNvim](https://github.com/NormalNvim/NormalNvim)
* [Compiler.nvim](https://github.com/Zeioth/compiler.nvim)
* [Markmap.nvim](https://github.com/Zeioth/dooku.nvim)
* [Dooku.nvim](https://github.com/Zeioth/dooku.nvim)
