-- ~/.config/nvim/init.lua

-- --------------------
-- LAZY.NVIM BOOTSTRAP
-- --------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- --------------------
-- GLOBAL OPTIONS
-- --------------------
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.termguicolors = true   -- Enable true color support
vim.opt.mouse = "a"            -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.ignorecase = true      -- Ignore case in search patterns
vim.opt.smartcase = true       -- Override ignorecase if pattern has uppercase
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Show matches incrementally
vim.opt.wrap = false           -- Disable line wrapping
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns visible left/right of cursor
vim.opt.tabstop = 4            -- Number of spaces a <Tab> in the file counts for
vim.opt.softtabstop = 4        -- Number of spaces a <Tab> counts for editing
vim.opt.shiftwidth = 4         -- Number of spaces to use for autoindent
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.autoindent = true      -- Copy indent from current line when starting a new line
vim.opt.smartindent = true     -- Smarter autoindenting for C-like languages

-- --------------------
-- KEYMAPPINGS (Example - add your own)
-- --------------------
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = "\\"

-- Example: Save file
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
-- Example: Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })


-- --------------------
-- PLUGIN SETUP (LAZY.NVIM)
-- --------------------
require("lazy").setup({
    -- Core editor enhancements
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} }, -- Example theme
    { "nvim-lua/plenary.nvim" }, -- Utility functions, often a dependency
    { "nvim-neotest/nvim-nio" },

    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for icons
        config = function()
            require("nvim-tree").setup({})
        end,
    },

    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for icons
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto", -- Or your preferred theme (e.g., 'tokyonight')
                    -- ... other lualine options
                }
            })
        end,
    },

    -- Autopairs
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

    -- Commenting
    { "numToStr/Comment.nvim", opts = {} },

    -- Git integration
    { "lewis6991/gitsigns.nvim", opts = {} },

    -- Which-key (shows keybindings)
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
    },

    -- Mason and LSP Support (Your existing setup, slightly re-ordered)
    { "williamboman/mason.nvim", build = ":MasonUpdate" }, -- Ensure Mason is updated
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    -- Completion Plugins (Your existing setup)
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" }, -- For Luasnip integration
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- Snippet engine
    { "rafamadriz/friendly-snippets" }, -- A collection of snippets

    -- Markdown Preview (from your plugins.lua)
    {
      "iamcco/markdown-preview.nvim",
      build = function() vim.cmd["mkdp#util#install"]() end,
      ft = { "markdown" },
      config = function ()
        -- You can add specific config for markdown-preview here if needed
        -- e.g. vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })
      end
    },

    -- VimTeX for LaTeX (Your existing setup)
    {
      "lervag/vimtex",
      ft = { "tex" },
      config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk"
        -- You can add VimTeX specific keymaps here if desired
        -- e.g. vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<cr>", { desc = "VimTeX Compile" })
      end
    },

    -- Debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui", -- UI for nvim-dap
            "theHamsta/nvim-dap-virtual-text", -- Shows debug info in virtual text
            "nvim-telescope/telescope-dap.nvim", -- DAP integration for Telescope
        },
    },

    -- Integrated Terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]], -- Open terminal with Ctrl+\
                direction = "float", -- Or 'horizontal' or 'vertical'
                -- other options...
            })
        end,
    },

}, {
    -- Lazy.nvim options (if any)
    -- For example, to set a default theme before plugins load:
    -- ui = { theme = "tokyonight" }
})

-- --------------------
-- PLUGIN CONFIGURATIONS (After lazy.setup)
-- --------------------

-- Mason Setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",          -- Python
        "clangd",           -- C/C++
        "rust_analyzer",    -- Rust
        "lua_ls",           -- Lua (for Neovim config itself)
        "bashls",           -- Bash/Shell
        "dockerls",         -- Dockerfile
        "jsonls",           -- JSON
        "yamlls",           -- YAML
        "marksman",         -- Markdown (alternative to a full LSP, good for linting/formatting)
        "lemminx",          -- XML
        -- Add other LSPs you commonly use: e.g., tsserver (TypeScript/JavaScript), gopls (Go)
    }
})

-- LSP & Completion Setup
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- For autopairs with cmp

-- nvim-cmp setup
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For snippets
        { name = "buffer" },
        { name = "path" },
    })
})

-- nvim-autopairs integration with nvim-cmp
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- LSP server setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            -- on_attach = function(client, bufnr)
            --     -- Add your per-LSP keymaps here if needed
            --     -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
            --     -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
            --     -- etc.
            -- end,
        })
    end,
    -- Example: Specific settings for lua_ls (Lua Language Server)
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false },
                },
            },
        })
    end,
})

-- nvim-dap and nvim-dap-ui setup
local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Example DAP Keymaps (place these in your keymappings section or here)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP: Run Last" })
vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "DAP: Toggle UI" })

-- Telescope DAP integration
require("telescope").load_extension("dap")
vim.keymap.set("n", "<leader>xdc", require("telescope").extensions.dap.commands, { desc = "DAP Commands" })
vim.keymap.set("n", "<leader>xdg", require("telescope").extensions.dap.configurations, { desc = "DAP Configurations" })
vim.keymap.set("n", "<leader>xdl", require("telescope").extensions.dap.list_breakpoints, { desc = "DAP List Breakpoints" })
vim.keymap.set("n", "<leader>xdv", require("telescope").extensions.dap.variables, { desc = "DAP Variables" })
vim.keymap.set("n", "<leader>xdf", require("telescope").extensions.dap.frames, { desc = "DAP Frames" })


-- Set a colorscheme (after lazy.nvim setup if the theme is managed by lazy)
vim.cmd.colorscheme "tokyonight" -- Or your preferred theme
