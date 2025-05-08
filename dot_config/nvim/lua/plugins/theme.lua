return {
    {
         "shaunsingh/solarized.nvim",
	 lazy = false,
	 config = function()
	     -- load the colorscheme
	     vim.cmd([[colorscheme solarized]])
         end,
    }
}
