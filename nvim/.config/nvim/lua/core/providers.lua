-- Provider configurations for health checks

-- Python provider
if vim.fn.executable('python3') == 1 then
  vim.g.python3_host_prog = vim.fn.exepath('python3')
elseif vim.fn.executable('python') == 1 then
  vim.g.python3_host_prog = vim.fn.exepath('python')
else
  vim.g.loaded_python3_provider = 0
end

-- Node.js provider
if vim.fn.executable('node') == 1 then
  vim.g.node_host_prog = vim.fn.exepath('node')
else
  vim.g.loaded_node_provider = 0
end

-- Disable unused providers to avoid warnings
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Enhanced clipboard configuration for Windows/WSL
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
elseif vim.fn.has('win32') == 1 then
  -- Windows clipboard should work by default with unnamedplus
  vim.opt.clipboard = 'unnamedplus'
end
