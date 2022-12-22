-- Session management
return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		require("auto-session").setup({
			cwd_change_handling = false,
			bypass_session_save_file_types = { "neo-tree" },
			pre_save_cmds = {
				function()
					require("neo-tree.sources.manager").close_all()
				end,
			},
		})
	end,
}
