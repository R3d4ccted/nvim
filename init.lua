require("lazy_init") -- Load lazy.nvim (if not already in your config)

require("lazy").setup({
    -- Mason and LSP Support
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    -- Completion Plugins
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },

    -- Markdown Preview
    {
      "iamcco/markdown-preview.nvim",
      build = function() vim.fn["mkdp#util#install"]() end,
      ft = { "markdown" },
    },

    -- VimTeX for LaTeX
    {
      "lervag/vimtex",
      ft = { "tex" },
      config = function()
        vim.g.vimtex_view_method = "zathura" -- Change if using another viewer
        vim.g.vimtex_compiler_method = "latexmk"
      end
    },
})

-- Mason Setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "clangd", "rust_analyzer"}
})

-- LSP & Completion Setup
local lspconfig = require("lspconfig")
local cmp = require("cmp")

cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- Automatically set up LSP servers
require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
    end,
})

vim.wo.number = true
vim.wo.relativenumber = true


