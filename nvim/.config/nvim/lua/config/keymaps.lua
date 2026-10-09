-- keymaps.lua — portado desde nixvim (keymaps.nix), estilo LazyVim.
local map = vim.keymap.set

-- ── j/k con wrap (expr) ─────────────────────────────────────────────
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", silent = true, expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", silent = true, expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", silent = true, expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", silent = true, expr = true })

-- ── windows: C-hjkl mover, C-Arrows resize ──────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", silent = true, remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", silent = true, remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", silent = true, remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", silent = true, remap = true })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase Window Height", silent = true })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease Window Height", silent = true })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease Window Width", silent = true })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase Window Width", silent = true })
-- grupo windows (<leader>w; <C-w> sigue valiendo)
map("n", "<leader>ww", "<C-w>p", { desc = "Other Window", silent = true, remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", silent = true, remap = true })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split Below", silent = true })
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split Right", silent = true })
map("n", "<leader>wm", "<cmd>only<CR>", { desc = "Maximize (only)", silent = true })

-- ── mover lineas con A-j/k ──────────────────────────────────────────
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move Down", silent = true })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move Up", silent = true })
map("i", "<A-j>", "<esc><cmd>m .+1<CR>==gi", { desc = "Move Down", silent = true })
map("i", "<A-k>", "<esc><cmd>m .-2<CR>==gi", { desc = "Move Up", silent = true })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move Down", silent = true })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move Up", silent = true })

-- ── buffers ─────────────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev Buffer", silent = true })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer", silent = true })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer", silent = true })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer", silent = true })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer", silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer", silent = true })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to Other Buffer", silent = true })
map("n", "<leader>`", "<cmd>e #<CR>", { desc = "Switch to Other Buffer", silent = true })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer", silent = true })
map("n", "<leader>bD", "<cmd>bd<CR>", { desc = "Delete Buffer and Window", silent = true })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers", silent = true })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left", silent = true })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right", silent = true })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin", silent = true })
map("n", "<leader>bj", "<cmd>BufferLinePick<CR>", { desc = "Pick Buffer", silent = true })
map("n", "[B", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer prev", silent = true })
map("n", "]B", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next", silent = true })
map("n", "<leader>be", "<cmd>Neotree buffers toggle<CR>", { desc = "Buffer Explorer", silent = true })

-- ── save ────────────────────────────────────────────────────────────
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save File", silent = true })
map("n", "<leader>fs", "<cmd>w<CR><esc>", { desc = "Save File", silent = true })

-- ── file/find (Telescope) ───────────────────────────────────────────
map("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find Files (Root)", silent = true })
map("n", "<leader>fF", "<cmd>Telescope find_files cwd=%:p:h<CR>", { desc = "Find Files (cwd)", silent = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", silent = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent", silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers", silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help", silent = true })
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New File", silent = true })
map("n", "<leader>fe", "<cmd>Neotree toggle<CR>", { desc = "Explorer NeoTree", silent = true })
map("n", "<leader>fE", "<cmd>Neotree toggle dir=%:p:h<CR>", { desc = "Explorer NeoTree (cwd)", silent = true })
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer NeoTree", silent = true, remap = true })
map("n", "<leader>E", "<cmd>Neotree toggle dir=%:p:h<CR>", { desc = "Explorer NeoTree (cwd)", silent = true, remap = true })
map("n", "<leader>ge", "<cmd>Neotree git_status toggle<CR>", { desc = "Git Explorer", silent = true })
map("n", "<leader>ft", "<cmd>split | terminal<CR>", { desc = "Terminal", silent = true })

-- ── search extra (grupo s) ──────────────────────────────────────────
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Grep (cwd)", silent = true })
map("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent", silent = true })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics", silent = true })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Help Pages", silent = true })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps", silent = true })

-- ── code / LSP (grupo c) ────────────────────────────────────────────
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition", silent = true })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References", silent = true })
map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Goto Type Definition", silent = true })
map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", { desc = "Goto Implementation", silent = true })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover", silent = true })
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action", silent = true })
map({ "n", "x" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format", silent = true })
map({ "n", "x" }, "<leader>cF", "<cmd>lua require('conform').format({ formatters = { 'injected' } })<CR>", { desc = "Format Injected Langs", silent = true })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle<CR>", { desc = "Symbols (Trouble)", silent = true })
map("n", "<leader>cS", "<cmd>Trouble lsp toggle<CR>", { desc = "LSP references/definitions/... (Trouble)", silent = true })
map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename", silent = true })
map("n", "<leader>K", "<cmd>norm! K<CR>", { desc = "Keywordprg", silent = true })

-- ── diagnostics / quickfix (grupo x, trouble) ───────────────────────
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)", silent = true })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)", silent = true })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)", silent = true })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)", silent = true })
map("n", "[q", function()
  if require("trouble").is_open() then
    require("trouble").prev({ skip_groups = true, jump = true })
  else
    local ok, err = pcall(vim.cmd.cprev)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = "Previous Trouble/Quickfix Item", silent = true })
map("n", "]q", function()
  if require("trouble").is_open() then
    require("trouble").next({ skip_groups = true, jump = true })
  else
    local ok, err = pcall(vim.cmd.cnext)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = "Next Trouble/Quickfix Item", silent = true })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Prev Diagnostic", silent = true })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic", silent = true })

-- ── quit / session (grupo q) ────────────────────────────────────────
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All", silent = true })
map("n", "<leader>qs", "<cmd>lua require('auto-session').SaveSession()<CR>", { desc = "Save Session", silent = true })
map("n", "<leader>ql", "<cmd>lua require('auto-session').RestoreSession()<CR>", { desc = "Restore Session", silent = true })
map("n", "<leader>qd", "<cmd>Dashboard<CR>", { desc = "Dashboard", silent = true })

-- ── tabs (grupo <tab>) ──────────────────────────────────────────────
map("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last Tab", silent = true })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Close Other Tabs", silent = true })
map("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab", silent = true })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab", silent = true })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab", silent = true })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab", silent = true })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab", silent = true })

-- ── UI (grupo u) ────────────────────────────────────────────────────
map("n", "<leader>ur", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / Clear hlsearch / Diff Update", silent = true })

-- ── misc ────────────────────────────────────────────────────────────
map("n", "<esc>", "<cmd>nohlsearch<CR><esc>", { desc = "Escape and Clear hlsearch", silent = true })
map("n", "n", "'Nn'[v:searchforward] . 'zv'", { desc = "Next Search Result", silent = true, expr = true })
map("x", "n", "'Nn'[v:searchforward]", { desc = "Next Search Result", silent = true, expr = true })
map("o", "n", "'Nn'[v:searchforward]", { desc = "Next Search Result", silent = true, expr = true })
map("n", "N", "'nN'[v:searchforward] . 'zv'", { desc = "Prev Search Result", silent = true, expr = true })
map("x", "N", "'nN'[v:searchforward]", { desc = "Prev Search Result", silent = true, expr = true })
map("o", "N", "'nN'[v:searchforward]", { desc = "Prev Search Result", silent = true, expr = true })
map("i", ",", ",<c-g>u", { desc = "Add undo break-point", silent = true })
map("i", ".", ".<c-g>u", { desc = "Add undo break-point", silent = true })
map("i", ";", ";<c-g>u", { desc = "Add undo break-point", silent = true })
map("x", "<", "<gv", { desc = "Better indenting", silent = true })
map("x", ">", ">gv", { desc = "Better indenting", silent = true })
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<CR>fxa<bs>", { desc = "Add Comment Below", silent = true })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<CR>fxa<bs>", { desc = "Add Comment Above", silent = true })
map("n", "<leader>?", "<cmd>WhichKey<CR>", { desc = "Buffer Keymaps (which-key)", silent = true })
map("n", "gx", "<cmd>lua vim.ui.open(vim.fn.expand('<cfile>'))<CR>", { desc = "Open with system app", silent = true })

-- ── flash (motion) ──────────────────────────────────────────────────
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash", silent = true })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter", silent = true })
map("o", "r", function() require("flash").remote() end, { desc = "Remote Flash", silent = true })
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search", silent = true })
