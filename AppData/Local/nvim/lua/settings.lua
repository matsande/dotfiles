-- TODO: Convert these
vim.cmd([[
    :set tabstop=4
    :set softtabstop=4
    :set shiftwidth=4
    :set expandtab
    :set autoindent
    :set copyindent
    :set ignorecase smartcase
    :set number
    :set relativenumber
    :set mouse=a
]])

vim.cmd('colorscheme onedark_vivid')

vim.cmd('language en_US')

vim.cmd([[
    let NERDTreeMapActivateNode='<space>'
    let NERDTreeHijackNetrw = 1
    let NERDTreeQuitOnOpen = 1
    let NERDTreeDirArrows = 1
    let NERDTreeMinimalUI = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
]])

