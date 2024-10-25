return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      dependencies = { 'GianniBYoung/chezmoi-telescope.nvim' },
      config = function()
	      require("telescope").load_extension("chezmoi")
      end,
    }
