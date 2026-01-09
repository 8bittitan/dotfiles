return {
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        pylint = { enabled = true, executable = 'pylint' },
        pyflakes = { enabled = true },
        pycodestyle = { enabled = false },
        flake8 = { enabled = false },
        pylsp_mypy = { enabled = true },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
      },
    },
  },
}
