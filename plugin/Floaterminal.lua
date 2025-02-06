
local state = {
    floating = {
        buf = -1,
        win = -1,
        job = 0,
    }
}
local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns -width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false,true)
    end

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }
    
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return {buf = buf, win = win}
end

local show_terminal = function()
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
    state.floating.job = vim.bo.channel
    vim.cmd('startinsert')
end

local hide_terminal = function()
    state.floating.job = vim.bo.channel
    vim.api.nvim_win_hide(state.floating.win)
end

local toggle_terminal = function()
    if vim.api.nvim_win_is_valid(state.floating.win) then
        hide_terminal()
    else
        show_terminal()
    end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({"n", "t"}, "<tab><leader>", toggle_terminal)

vim.keymap.set("n", "<leader>ls", function()
    vim.fn.chansend(state.floating.job, {"ls -al\r\n"})
end)

local selected_text = function()
  local mode = vim.api.nvim_get_mode().mode
  local opts = {}
  -- \22 is an escaped version of <c-v>
  if mode == "v" or mode == "V" or mode == "\22" then opts.type = mode end
  return vim.fn.getregion(vim.fn.getpos "v", vim.fn.getpos ".", opts)
end

vim.keymap.set("v", "<tab><leader>", function()
    local lines = selected_text()

    print(lines)
    show_terminal()
    vim.fn.chansend(state.floating.job, {table.concat(lines, "\r\n")})

end)

