return {
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
      vim.g.vimtex_view_method = "zathura" -- Change if you use another PDF viewer
      vim.g.vimtex_compiler_method = "latexmk"
    end
  },
}

