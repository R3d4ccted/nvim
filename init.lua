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
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- --------------------
-- KEYMAPPINGS
-- --------------------
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = "\\"

-- General
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>", { desc = "Quit Current (force)" })
vim.keymap.set("n", "<leader>Qa", "<cmd>qa!<cr>", { desc = "Quit All (force)" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>so", "<cmd>source %<cr>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>ESC", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Buffer/Tab Navigation
vim.keymap.set("n", "<leader>.", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>,", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>buffers<cr>", { desc = "List buffers" })

-- File Explorer
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate window right" })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>so", "<cmd>only<cr>", { desc = "Close other windows (only this one)" })

-- <c-\> for general toggle
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm Float" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "ToggleTerm Horizontal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "ToggleTerm Vertical" })
vim.keymap.set("n", "<leader>lg", "<cmd>ToggleTerm lazygit<cr>", { desc = "ToggleTerm Lazygit" })


-- LSP (some common LSP actions, relies on LSP being attached to the buffer)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Go to Declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Go to Implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP Go to References" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, { desc = "LSP Format Document" })
vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })


-- --------------------
-- PLUGIN SETUP (LAZY.NVIM)
-- --------------------
require("lazy").setup({
    -- Core
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" }, -- Icon pack

    -- UI
    { "nvim-lualine/lualine.nvim" }, -- Statusline
    { "akinsho/bufferline.nvim", version = "*" }, -- Bufferline/Tabs

    -- File Explorer
    { "nvim-tree/nvim-tree.lua" },

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

    -- Syntax & Highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- LSP & Completion
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    { "rafamadriz/friendly-snippets" },

    -- Utility
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    { "numToStr/Comment.nvim" },
    { "JoosepAlviste/nvim-ts-context-commentstring" }, -- Smarter commenting
    { "lewis6991/gitsigns.nvim", opts = {} },
    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
    { "akinsho/toggleterm.nvim", version = "*" },

    -- Debugger
    { "nvim-neotest/nvim-nio" },
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
})

-- --------------------
-- PLUGIN CONFIGURATIONS (After lazy.setup)
-- --------------------

-- Set theme
vim.cmd.colorscheme "tokyonight"

-- Bufferline (Tabs)
require("bufferline").setup({
    options = {
        mode = "buffers", -- Or "tabs"
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = true,
        -- Enable mouse clicks
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        }
    }
})

-- Lualine (Statusline)
require("lualine").setup({
    options = {
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
    },
})

-- NvimTree (File Explorer)
require("nvim-tree").setup({})

-- Telescope (Fuzzy Finder)
require("telescope").setup({})

-- Treesitter (Syntax)
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "rust" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
})

-- Commenting
require("Comment").setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

-- LSP, Mason, and Completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright", "clangd", "rust_analyzer", "lua_ls", "bashls",
        "dockerls", "jsonls", "yamlls", "marksman", "lemminx",
    },
    handlers = {
        function(server_name) -- default handler
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function() -- custom handler for lua_ls
            require("lspconfig").lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })
        end,
    }
})

local cmp = require("cmp")

-- Now, use that 'cmp' variable to configure the plugin
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    })
})
