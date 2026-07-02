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
vim.keymap.set("n", "<leader>c", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

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
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Only This Tab" })

vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to Definition" })
vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Go to Implementation" })
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "Go to References" })
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })

--- git comms
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Git Stage Hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Git Reset Hunk" })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git Preview Hunk" })
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git Diff This" })
vim.keymap.set("n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Git Toggle Deleted" })
vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Git Toggle Line Blame" })
vim.keymap.set("n", "<leader>gL", "<cmd>Gitsigns setqflist<cr>", { desc = "Git Set Quickfix List" })
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Git Reset Buffer" })
vim.keymap.set("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Git Stage Buffer" })
vim.keymap.set("n", "<leader>gU", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Git Undo Stage Hunk" })

-- --------------------
-- PLUGINS
-- --------------------
require("lazy").setup({
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-lua/plenary.nvim" },
    { "folke/which-key.nvim", event = "VeryLazy" },
    { "akinsho/bufferline.nvim", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "iamironz/android-nvim-plugin",
        lazy = false,
        config = function()
            require("android").setup()
        end,
    },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-lualine/lualine.nvim" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "windwp/nvim-autopairs", event = "InsertEnter" },
    { "numToStr/Comment.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "akinsho/toggleterm.nvim", version = "*" },
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim"}, 
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "github/copilot.vim" },
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

require("which-key").setup({})
require("nvim-tree").setup({})
require("telescope").setup({})
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "javascript", "typescript", "python", "rust", "markdown", "html", "css", "json", "yaml", "bash", "gitignore", "dockerfile", "go", "cpp", "java", "php" },
    highlight = { enable = true },
})

require("Comment").setup()
require("gitsigns").setup()
require("toggleterm").setup()

-- LSP + Completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()

local lspconfig = require("lspconfig")

-- Helper: get python from PATH (respects direnv if active)
local function get_python_path()
  return vim.fn.exepath("python3")
end

require("mason-lspconfig").setup({
    automatic_installation = false,
    ensure_installed = { "pyright", "clangd", "lua_ls" },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,
        ["pyright"] = function()
            lspconfig.pyright.setup({
                capabilities = capabilities,
                settings = {
                    python = {
                        pythonPath = get_python_path(),
                    }
                }
            })
        end,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
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

require("bufferline").setup({
    options = {
        mode = "buffers", -- or "tabs"
        diagnostics = "nvim_lsp",
        separator_style = "slant", -- "slant" | "thick" | "thin"
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
    }
})

