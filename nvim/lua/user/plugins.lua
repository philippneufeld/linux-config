local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
    git = {
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- colorschemes
    use "xiyaowong/nvim-transparent"
    use "lunarvim/darkplus.nvim"

    -- file explorer
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    -- snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "saadparwaiz1/cmp_luasnip"

    -- language server
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use "nvim-telescope/telescope.nvim"

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "p00f/nvim-ts-rainbow"

    -- autopairs
    use "windwp/nvim-autopairs"

    -- comments
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- git
    use "lewis6991/gitsigns.nvim"

    -- bufferline
    use "akinsho/bufferline.nvim"

    -- terminal
    use "akinsho/toggleterm.nvim"

    -- vimtex
    use "lervag/vimtex"

    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
