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

-- See config.lua for LSP mappings

-- Test
vim.api.nvim_create_user_command(
    'Notes',
    function()
        local commands = require("commands")
        commands.notes()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'PathClip',
    'let @+ = expand("%:p")',
    { nargs = 0 }
)

