local module = {}

local function keymap(mode, binding, command, description, opts)
	local defaults = {
		silent = true,
		expr = false,
		noremap = true,
		desc = description,
	}
	local options = vim.tbl_extend("force", defaults, opts or {})

	vim.keymap.set(mode, binding, command, options)
end

function module.nmap(binding, command, description, opts)
	keymap("n", binding, command, description, opts)
end

function module.imap(binding, command, description, opts)
	keymap("i", binding, command, description, opts)
end

function module.xmap(binding, command, description, opts)
	keymap("x", binding, command, description, opts)
end

function module.vmap(binding, command, description, opts)
	keymap("v", binding, command, description, opts)
end

function module.omap(binding, command, description, opts)
	keymap("o", binding, command, description, opts)
end

return module
