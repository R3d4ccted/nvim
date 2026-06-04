-- <Space>ss = build & run (safe flags)
vim.keymap.set("n", "<leader>ss", function()
  require("pwn.c_runner").build_and_run({
    ask_args = true,
    close_build_on_success = true,
    close_run_on_exit = false, -- change to true if you want auto-close run terminal too
  })
end, { buffer = true, desc = "Build & run C (to /tmp)" })

-- <Space>sS = build & run (vuln-ish flags)
vim.keymap.set("n", "<leader>sS", function()
  require("pwn.c_runner").build_and_run({
    ask_args = true,
    vuln_flags = true,
    close_build_on_success = true,
    close_run_on_exit = false,
  })
end, { buffer = true, desc = "Build & run C (no-pie/no-ssp)" })

