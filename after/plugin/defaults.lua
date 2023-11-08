
-- Set highlight on search
vim.o.hlsearch = true

-- Show where current search pattern matches (while typing)
vim.o.incsearch = true

--[[
let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
set shellquote= shellxquote=
--]]

-- use <Esc> to exit terminal-mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

-- gc to open windows terminal
vim.keymap.set('n', 'gc', ':!wt -d "%:h"<CR>')

-- delete all other buffers except the current one
vim.keymap.set('n', '<F1>', ':%bd <BAR> e# <BAR> bd# <CR>', { silent = true })

-- change vim's directory to the directory of the current file
vim.keymap.set('n', '<F5>', ':cd %:p:h <Enter>:pwd <Enter>')

-- delete extraneous spaces at the end of every line
vim.keymap.set('n', '<F6>', ':%s:[ \\t]\\+$::g <Enter> :noh <Enter>')

-- toggle line numbers
vim.keymap.set('n', '<F7>', 'set number!<Enter>')

-- copy current line to clipboard
vim.keymap.set('n', '<F9>', '"*yy')

-- copy <something> to clipboard (you need to fill in last keystroke)
vim.keymap.set('n', '<F10>', '"*y')

-- copy rest of file to clipboard
vim.keymap.set('n', '<F11>', '"*yG')

-- copy entire file to clipboard (regardless of where you are in file)
vim.keymap.set('n', '<F12>', ':%y *<CR>')

-- show/hide spaces, tabs, etc.
vim.keymap.set('n', '<leader>s', ':set nolist!', { silent = true })

-- use ctrl-v to paste in insert mode and command mode
vim.keymap.set('i', '<C-v>', '<ESC>"*pa')
vim.keymap.set('c', '<C-v>', '<C-R>+')

-- copy filename and line number to clipboard
vim.keymap.set('n', '<leader>n', ':let @*=expand("%:t") . ":" . line(".")<CR>:echo "Copied filename/line no to clipboard"<CR>')

-- copy filename (including path) to clipboard
vim.keymap.set('n', '<leader>f', ':let @*=expand("%:p")<CR>:echo "Copied filename (incl. path) to clipboard"<CR>')

-- copy directory to clipboard
vim.keymap.set('n', '<leader>d', ':let @*=expand("%:p:h")<CR>:echo "Copied directory to clipboard"<CR>')

-- copy filename (including) path and line number to clipboard
-- vim.keymap.set('n', '<leader>l', ':let @*="load -r " . line(".") . " " . expand("%:p")<CR>:echo "Copied filename (incl. path) AND linenumber to clipboard"<CR>')

-- don't wrap lines
vim.o.wrap = false
-- make sure gg goes to beginning of line
vim.o.sol = true
-- no mouse
vim.o.mouse = ''

-- always use spaces and make tabs 4 spaces wide
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.textwidth = 100

vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim,html,jinja,svelte",
  command = [[let b:delimitMate_matchpairs = "(:),[:],{:}"]],
})

vim.g.closetag_filetypes = 'html,xhtml,phtml,svelte,jinja'
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format({timeout_ms = 2500})<CR>')

vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua require('flattensql').flatten_sql()<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<F8>", "<cmd>lua require('flattensql').flatten_sql_highlighted()<CR>", { noremap = true })
-- reformat highlighted section with sql-formatter
vim.api.nvim_set_keymap("x", "<leader>q", ":!sql-formatter --config D:/sql-formatter.json<CR>", {})

require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    else
      return 20
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  autochdir = true,
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',
  close_on_exit = true,
  shell = 'pwsh',
  auto_scroll = true,
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved',
    -- like `size`, width and height can be a number or function which is passed the current terminal
    -- width = <value>,
    -- height = <value>,
    winblend = 3,
    -- zindex = <value>,
  },
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}
