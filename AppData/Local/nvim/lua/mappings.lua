function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

nmap('<leader>h', '<cmd>noh<cr>')

-- Telescope
nmap('<leader>ff', '<cmd>Telescope find_files<cr>')
nmap('<leader>fg', '<cmd>Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')

-- Buffer nav
nmap('<C-h>', '<cmd>bprev<cr>')
nmap('<C-l>', '<cmd>bnext<cr>')

imap('jj', '<Esc>')
nmap('<C-e>', '<cmd>NERDTreeToggle<CR>')

vim.api.nvim_create_user_command(
    'CopyPath',
    'let @+ = expand("%:p")',
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'CopyName',
    'let @+ = expand("%")',
    { nargs = 0 }
)

