return require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    -- Color theme
    use 'joshdick/onedark.vim'
    use "olimorris/onedarkpro.nvim"

    -- Infoline
    use 'nvim-lualine/lualine.nvim'

    -- Editor config
    use 'gpanders/editorconfig.nvim'
end)

-- PreReqs:
-- git
-- git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
-- cargo install ripgrep
-- https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/IBMPlexMono/Mono/complete/Blex%20Mono%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf
