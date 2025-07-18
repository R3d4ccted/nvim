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
vim.opt.shortmess:append("I") -- Disable intro message

-- --------------------
-- KEYMAPPINGS
-- --------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>", { desc = "Quit Current (force)" })
vim.keymap.set("n", "<leader>Qa", "<cmd>qa!<cr>", { desc = "Quit All (force)" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>so", "<cmd>source %<cr>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>ESC", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate window right" })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>so", "<cmd>only<cr>", { desc = "Close other windows" })

vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm Float" })

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })

vim.keymap.set("n", "<leader>as", "<cmd>Alpha<CR>", { desc = "Show ASCII Splash" })

-- --------------------
-- PLUGINS
-- --------------------
require("lazy").setup({
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-lualine/lualine.nvim" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "windwp/nvim-autopairs", event = "InsertEnter" },
    { "numToStr/Comment.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "akinsho/toggleterm.nvim", version = "*" },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim", version = "*"}, 
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                "=================================================",
                "================*###%%##%%##*====================",
                "============+#*++=++++++=+++=+###=========+#=====",
                "==========*#++++*+++===++*++=+++**#*======**#*===",
                "========+#++++#####%%%@@@%%#+++++=++#*====#++#+==",
                "=======**++=+%@%#*#%%%%%%%%%@*+=+++*++#=+#*++**==",
                "=====+#+=+++%@%#**++==++*#%%@@++++++*++%#+++*%##+",
                "====#++++=+%*=+========+===+=*%++=+++**#*=*++++#=",
                "==+*++===+*++++========+====+++++++=++**##++++#==",
                "=+#=++++++*++*+++++++++++++=+++++++=++*%#*##%@+==",
                "=#=+%++=+*+=*%++++++++++#++++++++++++*+%@@%%%%===",
                "+*+##+++=*++%%++++++++++##+++++++++++*+#@%@@%+===",
                "+*#*#++++*#*++*+#+++++*+#+**+++++++++*++@@@@%====",
                "=*#**++++*###%####*+++%#++++#%#+++++++++%@%##====",
                "====#+++++%@*+++#%*#+*++++#@@%++++++##+*%@@**====",
                "====+#+**+**=====+=========+#*+++++*#%+%%#++#+===",
                "=====+#*#%#**=====+++======***#+++*#+%#*##+++#===",
                "======**%**#*+=====+========*#+++#*++**+#=**=+*==",
                "++=+++**++***+##%%#**###%@###+#%*+++**++#===*++*=",
                "+++++#*++*****%%@*+%++%@%%%%*****+++***+**===#+#=",
                "===+#**#%****#%%%%###@%%*##%#******+*******=****=",
                "===#*#*=+#**%@@%**+*#*%%%#%@@%***#********%#***==",
                "===+#**#*=*%%@@%**%###%%@%%%@@@#########%#*%+====",
                "==============###+=#*#+==========================",
                "=================================================",
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file", "<cmd>ene<CR>"),
                dashboard.button("q", "󰗼  Quit NVIM", "<cmd>qa<CR>"),
            }

            dashboard.section.footer.val = {
                "Welcome, Kurond~"
            }

            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end
    }

})

-- --------------------
-- CONFIGS
-- --------------------

vim.cmd.colorscheme "tokyonight"

require("lualine").setup({
    options = {
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
    },
})

require("nvim-tree").setup({})
require("telescope").setup({})
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "javascript", "typescript", "python", "rust" },
    highlight = { enable = true },
})

require("Comment").setup()
require("gitsigns").setup()
require("toggleterm").setup()

-- LSP + Completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "clangd", "lua_ls" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function()
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

