return {
  -- Needed for file path resolution mainly
  -- https://github.com/nvim-lua/plenary.nvim/
  {
  'nvim-lua/plenary.nvim',
  lazy = false,
},

  -- TODO: Enable after https://github.com/nvim-neorocks/nvim-busted-action/issues/4 is resolved
  -- {
  --   'antosha417/nvim-lsp-file-operations',
  --   lazy = true,
  -- },

  {
    'mikavilpas/yazi.nvim',
    lazy = false,
    opts = {},
    cmd = {
      'Yazi',
      'Yazi cwd',
      'Yazi toggle',
    },
  },

  {
    "rolv-apneseth/tfm.nvim",
    lazy = false,
    opts = {
      -- TFM to use
      -- Possible choices: "ranger" | "nnn" | "lf" | "vifm" | "yazi" (default)
      file_manager = "yazi",
      -- Replace netrw entirely
      -- Default: false
      replace_netrw = true,
      -- Enable creation of commands
      -- Default: false
      enable_cmds = true,
      -- Custom keybindings only applied within the TFM buffer
      -- Default: {}
      keybindings = {
        ["<ESC>"] = "q",
        ["<C-v>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR>",
        ["<C-x>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR>",
        ["<C-t>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.tabedit)<CR>",
      },
      -- Customize UI. The below options are the default
      ui = {
        border = "rounded",
        height = 1,
        width = 1,
        x = 0.5,
        y = 0.5,
      },
    },
    keys = {
        {
            "<leader>me",
            function()
                require("tfm").open()
            end,
            desc = "TFM",
        },
        {
    "<leader>mc",
    function()
        require("tfm").select_file_manager(vim.fn.input("Change file manager: "))
    end,
    desc = "TFM - change selected file manager",
},
        {
            "<leader>mh",
            function()
                local tfm = require("tfm")
                tfm.open(nil, tfm.OPEN_MODE.split)
            end,
            desc = "TFM - horizontal split",
        },
        {
            "<leader>mv",
            function()
                local tfm = require("tfm")
                tfm.open(nil, tfm.OPEN_MODE.vsplit)
            end,
            desc = "TFM - vertical split",
        },
        {
            "<leader>mt",
            function()
                local tfm = require("tfm")
                tfm.open(nil, tfm.OPEN_MODE.tabedit)
            end,
            desc = "TFM - new tab",
        },
    },
  },

  -- Change some telescope options and a keymap to browse plugin files
   {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
    })
  end,
},

  -- Add telescope-fzf-native
   {
     "telescope.nvim",
     dependencies = {
       "nvim-telescope/telescope-fzf-native.nvim",
       build = "make",
       config = function()
         require("telescope").load_extension("fzf")
       end,
     },
   },

  -- Change trouble config
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- Add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- Override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },

  -- Add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util.lsp").on_attach(function(_, buffer)
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    opts = {
      servers = {
        tsserver = {},
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },

  -- Use LazyVim plugins for TypeScript
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- Extend treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- Change the default options of lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- Custom lualine options
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        -- Add your custom lualine config here
      }
    end,
  },

  -- Use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- Add jsonls and schemastore packages, and setup treesitter for json, json5, and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- Add additional tools to be installed with mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- Disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  -- Setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  -- Dashboard-Nvim für eine benutzerdefinierte Startseite
  {
    'glepnir/dashboard-nvim',
    lazy = false,
    config = function()
      require('dashboard').setup({
        -- Beispiel-Konfiguration für Dashboard-Nvim
        theme = 'hyper', -- Verschiedene Themen verfügbar, z.B. 'doom', 'hyper'
        config = {
          header = {
            "Welcome to Neovim"
          },
          center = {
            {
              icon = '  ',
              desc = 'Recently latest session                  ',
              shortcut = 'SPC s l',
              action = 'SessionLoad'
            },
            {
              icon = '  ',
              desc = 'Recently opened files                   ',
              action = 'DashboardFindHistory',
              shortcut = 'SPC f h'
            },
            {
              icon = '  ',
              desc = 'Find File                                ',
              action = 'Telescope find_files find_command=rg,--hidden,--files',
              shortcut = 'SPC f f'
            },
          },
        }
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false, -- Schließt Neo-tree, wenn es das letzte geöffnete Fenster ist
        popup_border_style = "rounded", -- Stil des Fensterrands für Pop-ups
        enable_git_status = true, -- Git-Status anzeigen
        enable_diagnostics = true, -- Diagnosen (Linter/Formatter) anzeigen
        window = {
          position = "left", -- Position des Neo-tree Fensters (links, rechts, oben, unten)
          width = 30, -- Breite des Fensters
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false, -- Dotfiles (versteckte Dateien) anzeigen
            hide_gitignored = false, -- Dateien, die von Git ignoriert werden, anzeigen
            hide_hidden = false, -- Weitere versteckte Dateien anzeigen (plattformabhängig)
          },
          follow_current_file = true, -- Dem aktuell geöffneten Buffer folgen
          group_empty_dirs = true, -- Leere Verzeichnisse gruppieren
          hijack_netrw_behavior = "open_current", -- Netrw Verhalten übernehmen
          use_libuv_file_watcher = true, -- Dateiwächter verwenden für aktuelle Dateiänderungen
        },
        buffers = {
          follow_current_file = true, -- Dem aktuell geöffneten Buffer folgen
          group_empty_dirs = true, -- Leere Verzeichnisse gruppieren
        },
        git_status = {
          window = {
            position = "float", -- Git-Status-Fenster als schwebendes Fenster
          },
        },
      })
end,
-- Konfiguration für Neo-tree mit Tastenkombinationen im gewünschten Format
keys = {
    {
        "<leader>mme",
        function()
            require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Toggle Neo-tree",
    },
    {
        "<leader>mmc",
        function()
            local file_manager = vim.fn.input("Change file manager: ")
            require("neo-tree.command").execute({ toggle = true, file_manager = file_manager })
        end,
        desc = "Neo-tree - change selected file manager",
    },
    {
        "<leader>mmh",
        function()
            require("neo-tree.command").execute({ open = true, layout = "split" })
        end,
        desc = "Neo-tree - horizontal split",
    },
    {
        "<leader>mmv",
        function()
            require("neo-tree.command").execute({ open = true, layout = "vsplit" })
        end,
        desc = "Neo-tree - vertical split",
    },
    {
        "<leader>mmt",
        function()
            require("neo-tree.command").execute({ open = true, layout = "tabedit" })
        end,
        desc = "Neo-tree - new tab",
    },
}
  },
}