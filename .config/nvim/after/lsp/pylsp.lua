return {
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        pylint = { enabled = false, executable = 'pylint', args = { '--max-line-length=100' } },
        pyflakes = { enabled = false },
        pycodestyle = {
          enabled = false,
        },
        flake8 = {
          enabled = false,
        },
        pylsp_mypy = { enabled = true },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
      },
    },
  },
}
