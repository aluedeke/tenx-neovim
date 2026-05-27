-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  -- File browser
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = { group_empty = true },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
  },

  -- Syntax highlighting (pinned to master branch — main has a different API)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "go", "python", "typescript", "javascript", "tsx",
          "lua", "bash", "yaml", "json", "dockerfile", "dart",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Git status UI in sign column + hunks
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true,
      })
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>")
    end,
  },

  -- Full git UI (status, stage, commit, diff)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("neogit").setup({})
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>")
    end,
  },
})
