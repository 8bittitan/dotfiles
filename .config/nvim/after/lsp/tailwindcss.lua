local experimentalOpts = {}
local cwd = vim.fn.getcwd()

if string.find(cwd, 'AlgoliaWeb') and not string.find(cwd, '_client_admin') then
  experimentalOpts = {
    configFile = '_client/.vscode/tailwind-vscode.config.js',
  }
end

if string.find(cwd, '_client') and not string.find(cwd, '_client_admin') then
  experimentalOpts = {
    configFile = '.vscode/tailwind-vscode.config.js',
  }
end

if string.find(cwd, '_client_admin') then
  experimentalOpts = {
    configFile = './tailwind.config.js',
  }
end

return {
  settings = {
    tailwindCSS = {
      experimental = experimentalOpts,
    },
  },
}
