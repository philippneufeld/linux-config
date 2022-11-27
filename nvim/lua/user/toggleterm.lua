local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup {
    direction = "float",
    shade_terminals = false,
    float_opts = {
        border = "curved",
    }
}

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local python = Terminal:new({ cmd = "python", hidden = "true" })
function term_python_toggle()
    python:toggle()
end
