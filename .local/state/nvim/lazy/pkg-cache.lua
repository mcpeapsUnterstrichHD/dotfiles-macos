return {pkgs={{file="lazy.lua",name="astrocore",source="lazy",spec=function()
return {
  "AstroNvim/astrocore",
  opts_extend = {
    "rooter.ignore.servers",
    "rooter.ignore.dirs",
    "sessions.ignore.buftypes",
    "sessions.ignore.dirs",
    "sessions.ignore.filetypes",
    "git_worktrees",
  },
}

end,dir="/Users/mahd/.local/share/nvim/lazy/astrocore",},{file="lazy.lua",name="astrolsp",source="lazy",spec=function()
return {
  "AstroNvim/astrolsp",
  opts_extend = {
    "formatting.disabled",
    "formatting.format_on_save.allow_filetypes",
    "formatting.format_on_save.ignore_filetypes",
    "servers",
  },
}

end,dir="/Users/mahd/.local/share/nvim/lazy/astrolsp",},{file="lazy.lua",name="astroui",source="lazy",spec=function()
return {
  "AstroNvim/astroui",
  opts_extend = {
    "status.winbar.enabled.filetype",
    "status.winbar.enabled.buftype",
    "status.winbar.enabled.bufname",
    "status.winbar.disabled.filetype",
    "status.winbar.disabled.buftype",
    "status.winbar.disabled.bufname",
  },
}

end,dir="/Users/mahd/.local/share/nvim/lazy/astroui",},{file="lazy.lua",name="blink.compat",source="lazy",spec=function()
return {
  {
    'saghen/blink.compat',
    lazy = true,
  },
}

end,dir="/Users/mahd/.local/share/nvim/lazy/blink.compat",},{file="community",name="plenary.nvim",source="lazy",spec={"nvim-lua/plenary.nvim",lazy=true,},dir="/Users/mahd/.local/share/nvim/lazy/plenary.nvim",},},version=12,}