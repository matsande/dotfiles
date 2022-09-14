return require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    -- Color theme
    use 'joshdick/onedark.vim'
    use "olimorris/onedarkpro.nvim"

    -- Infoline
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    -- superseded by:
    use 'nvim-lualine/lualine.nvim'

    -- File browser
    use 'preservim/nerdtree' 
    use 'ryanoasis/vim-devicons'

    -- File search
    use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
    use {'nvim-telescope/telescope-ui-select.nvim' }

    -- Editor config
    use 'gpanders/editorconfig.nvim'

    -- General dev
    use 'neovim/nvim-lspconfig' -- native LSP support
    use 'hrsh7th/nvim-cmp' -- autocompletion framework
    use 'hrsh7th/cmp-nvim-lsp' -- LSP autocompletion provider
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Terminal
    use { 'akinsho/toggleterm.nvim', tag = '*' }

    -- GO 
    use 'ray-x/go.nvim'

    use 'nvim-treesitter/nvim-treesitter'
end)


-- Take a look at https://github.com/arnvald/viml-to-lua/blob/main/lua/plugins.lua 
--
-- GO:
-- https://github.com/ray-x/go.nvim
--
-- PreReqs:
-- git
-- git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- cargo install ripgrep
-- https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/IBMPlexMono/Mono/complete/Blex%20Mono%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf
