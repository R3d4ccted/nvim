local M = {}

local state = {
  build_buf = nil,
  build_win = nil,
}

local function ensure_dir(path)
  vim.fn.mkdir(path, "p")
end

local function ensure_scratch_buf(existing, name)
  if existing and vim.api.nvim_buf_is_valid(existing) then
    return existing
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, name)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "log"
  return buf
end

local function write_lines(buf, lines)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local function open_right_vsplit_with_buf(buf)
  vim.cmd("rightbelow vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  return win
end

local function safe_close_win(win)
  if win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_close, win, true)
  end
end

local function run_system(cmd, cb)
  if vim.system then
    vim.system(cmd, { text = true }, function(res)
      cb(res.code or 1, res.stdout or "", res.stderr or "")
    end)
  else
    local out, err = {}, {}
    vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data) if data then vim.list_extend(out, data) end end,
      on_stderr = function(_, data) if data then vim.list_extend(err, data) end end,
      on_exit = function(_, code)
        cb(code, table.concat(out, "\n"), table.concat(err, "\n"))
      end,
    })
  end
end

function M.build_and_run(opts)
  opts = opts or {}

  vim.cmd("write")

  local src = vim.fn.expand("%:p")
  if src == "" then
    vim.notify("No file path for current buffer", vim.log.levels.ERROR)
    return
  end

  local base = vim.fn.expand("%:t:r")
  local outdir = "/tmp/nvim-pwn"
  ensure_dir(outdir)

  -- avoid collisions for same filename in different folders
  local hash = vim.fn.sha256(src):sub(1, 8)
  local outbin = string.format("%s/%s_%s", outdir, base, hash)

  local cmd = { "gcc", src, "-o", outbin, "-g", "-O0", "-Wall", "-Wextra" }
  if opts.vuln_flags then
    vim.list_extend(cmd, { "-fno-stack-protector", "-no-pie" })
  end

  local args = ""
  if opts.ask_args then
    args = vim.fn.input("args: ")
  end

  -- build log split
  state.build_buf = ensure_scratch_buf(state.build_buf, "Build Log")
  state.build_win = open_right_vsplit_with_buf(state.build_buf)
  write_lines(state.build_buf, {
    "$ " .. table.concat(cmd, " "),
    "",
    "[building...]",
  })

  run_system(cmd, function(code, stdout, stderr)
    vim.schedule(function()
      local lines = { "$ " .. table.concat(cmd, " "), "" }
      if stdout ~= "" then vim.list_extend(lines, vim.split(stdout, "\n", { plain = true })) end
      if stderr ~= "" then vim.list_extend(lines, vim.split(stderr, "\n", { plain = true })) end
      write_lines(state.build_buf, lines)

      if code ~= 0 then
        vim.notify("Build failed", vim.log.levels.ERROR)
        return
      end

      -- close build window after success (optional)
      if opts.close_build_on_success then
        safe_close_win(state.build_win)
        state.build_win = nil
      end

      -- run terminal split
      local run_cmd = outbin
      if args ~= "" then run_cmd = run_cmd .. " " .. args end

      vim.cmd("rightbelow vsplit")
      vim.cmd("terminal " .. vim.fn.shellescape(run_cmd))
      local term_buf = vim.api.nvim_get_current_buf()
      local term_win = vim.api.nvim_get_current_win()

      -- auto-close run window when program exits (optional)
      if opts.close_run_on_exit then
        vim.api.nvim_create_autocmd("TermClose", {
          buffer = term_buf,
          once = true,
          callback = function()
            safe_close_win(term_win)
          end,
        })
      end

      vim.cmd("startinsert")
    end)
  end)
end

return M

