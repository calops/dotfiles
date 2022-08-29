-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/rlabeyrie/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/rlabeyrie/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/rlabeyrie/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/rlabeyrie/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/rlabeyrie/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1»\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\24cwd_change_handling\1\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  catppuccin = {
    after = { "feline.nvim", "tabline-framework.nvim", "incline.nvim" },
    config = { "\27LJ\2\n∏\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\fcompile\1\0\1\fenabled\2\17integrations\1\0\0\fneotree\1\0\3\22transparent_panel\1\14show_root\2\fenabled\2\1\0\1\14telescope\2\nsetup\15catppuccin\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-conventionalcommits"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-conventionalcommits",
    url = "https://github.com/davidsierradz/cmp-conventionalcommits"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/hrsh7th/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\2\nî\1\0\0\6\0\a\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\0\0'\3\3\0B\1\2\0029\1\2\0015\3\5\0009\4\4\0B\4\1\2=\4\6\3B\1\2\1K\0\1\0\15components\1\0\0\bget\vfeline\nsetup*catppuccin.groups.integrations.feline\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/opt/feline.nvim",
    url = "https://github.com/feline-nvim/feline.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nŸ\1\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\2B\0\2\1K\0\1\0\nsigns\1\0\0\17changedelete\1\0\1\ttext\b‚îÉ\14topdelete\1\0\1\ttext\b‚Äæ\vdelete\1\0\1\ttext\6_\vchange\1\0\1\ttext\b‚îÉ\badd\1\0\0\1\0\1\ttext\b‚îÉ\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["guess-indent.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17guess-indent\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/guess-indent.nvim",
    url = "https://github.com/nmac427/guess-indent.nvim"
  },
  ["inc-rename.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15inc_rename\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/inc-rename.nvim",
    url = "https://github.com/smjonas/inc-rename.nvim"
  },
  ["incline.nvim"] = {
    config = { "\27LJ\2\nê\6\0\1\21\5!\2Å\0016\1\0\0009\1\1\0019\1\2\0016\3\0\0009\3\3\0039\3\4\0039\5\5\0B\3\2\2'\4\6\0B\1\3\2\18\4\1\0009\2\a\1'\5\b\0B\2\3\0026\3\t\0'\5\n\0B\3\2\0029\3\v\3\18\5\1\0\18\6\2\0B\3\3\0035\5\f\0=\4\r\5-\6\0\0009\6\14\6\18\b\4\0*\t\0\0B\6\3\2=\6\15\5-\6\1\0009\a\16\0\15\0\a\0X\b\1Ä-\6\2\0004\a\5\0005\b\17\0009\t\15\5=\t\18\b-\t\3\0009\t\15\t=\t\19\b>\b\1\a5\b\21\0\18\t\3\0'\n\20\0&\t\n\t>\t\1\b9\t\r\5=\t\18\b9\t\15\5=\t\19\b>\b\2\a5\b\22\0009\t\15\6=\t\18\b9\t\15\5=\t\19\b>\b\3\a4\b\3\0>\1\1\b>\b\4\a6\b\0\0009\b\23\b9\b\24\b9\n\5\0B\b\2\0025\t\25\0006\n\26\0\18\f\b\0B\n\2\4X\r\5Ä9\15\27\0149\16\27\0148\16\16\t\22\16\1\16<\16\15\tE\r\3\3R\r˘\127\18\n\6\0)\v\1\0)\f\4\0)\r\1\0M\v#Ä8\15\14\t)\16\0\0\1\16\15\0X\15\30Ä6\15\28\0009\15\29\15\18\17\a\0005\18\30\0009\19\15\n=\19\18\18-\19\4\0008\19\14\0199\19\15\19=\19\19\18B\15\3\0016\15\28\0009\15\29\15\18\17\a\0005\18\31\0'\19\20\0008\20\14\t&\19\20\19>\19\1\18-\19\4\0008\19\14\0199\19\r\19=\19\18\18-\19\4\0008\19\14\0199\19\15\19=\19\19\18B\15\3\1-\15\4\0008\n\14\15O\v›\1276\v\28\0009\v\29\v\18\r\a\0005\14 \0009\15\15\n=\15\18\14-\15\3\0009\15\15\15=\15\19\14B\v\3\1L\a\2\0\1¿\2¿\3¿\4¿\5¿\1\2\0\0\bÓÇ¥\1\0\0\1\2\0\0\bÓÇ¥\vinsert\ntable\rseverity\vipairs\1\5\0\0\3\0\3\0\3\0\3\0\bget\15diagnostic\1\2\0\0\bÓÇ∂\1\0\0\6 \nguibg\nguifg\1\2\0\0\bÓÇ∂\ffocused\abg\vdarken\afg\1\0\0\20get_icon_colors\22nvim-web-devicons\frequire\15^.+%.(.+)$\nmatch\a:.\bbuf\22nvim_buf_get_name\bapi\16fnamemodify\afn\bvimÁÃô≥\6≥ÊÃ˛\3\2…\4\1\0\f\0\26\00146\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0'\4\4\0B\2\2\0029\3\3\0'\5\5\0B\3\2\0029\4\3\0'\6\6\0B\4\2\0024\5\5\0009\6\3\0'\b\a\0B\6\2\2>\6\1\0059\6\3\0'\b\b\0B\6\2\2>\6\2\0059\6\3\0'\b\t\0B\6\2\2>\6\3\0059\6\3\0'\b\n\0B\6\2\0?\6\0\0006\6\0\0'\b\v\0B\6\2\0029\6\f\0065\b\14\0003\t\r\0=\t\15\b5\t\16\0005\n\17\0=\n\18\t5\n\20\0005\v\19\0=\v\21\n5\v\22\0=\v\23\n=\n\24\t=\t\25\bB\6\2\0012\0\0ÄK\0\1\0\vwindow\vmargin\rvertical\1\0\2\btop\3\0\vbottom\3\1\15horizontal\1\0\0\1\0\2\tleft\3\1\nright\3\1\14placement\1\0\2\rvertical\btop\15horizontal\nright\1\0\1\fpadding\3\0\vrender\1\0\0\0\nsetup\fincline\30DiagnosticVirtualTextHint\30DiagnosticVirtualTextInfo\30DiagnosticVirtualTextWarn\31DiagnosticVirtualTextError\vNormal\18InclineNormal\20InclineNormalNC\vget_hl\28catppuccin.utils.colors!tabline_framework.highlights\frequire\tÄÄ¿ô\4\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/opt/incline.nvim",
    url = "https://github.com/b0o/incline.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nè\2\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\17integrations\fneotree\1\0\0\1\0\3\22transparent_panel\1\14show_root\1\fenabled\2\1\0\5\31show_current_context_start\1\25show_current_context\2#show_trailing_blankline_indent\1\24max_indent_increase\3\1\19use_treesitter\2\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp_lines.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lsp_lines\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nX\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23popup_border_style\frounded\nsetup\rneo-tree\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire◊\a\1\0\v\0005\0Ä\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\19\0009\4\3\0009\4\4\0049\4\5\0045\6\a\0009\a\3\0009\a\6\a)\t¸ˇB\a\2\2=\a\b\0069\a\3\0009\a\6\a)\t\4\0B\a\2\2=\a\t\0069\a\3\0009\a\n\aB\a\1\2=\a\v\0069\a\3\0009\a\f\aB\a\1\2=\a\r\0069\a\3\0009\a\14\aB\a\1\2=\a\15\0069\a\3\0009\a\16\a5\t\17\0B\a\2\2=\a\18\6B\4\2\2=\4\3\0039\4\20\0009\4\21\0044\6\3\0005\a\22\0>\a\1\0065\a\23\0>\a\2\0064\a\3\0005\b\24\0>\b\1\aB\4\3\2=\4\21\0035\4\26\0003\5\25\0=\5\27\4=\4\28\0035\4\31\0006\5\0\0'\a\29\0B\5\2\0029\5\30\5B\5\1\2=\5 \4=\4!\0035\4$\0009\5\20\0009\5\"\0059\5#\5B\5\1\2=\5%\0049\5\20\0009\5\"\0059\5#\5B\5\1\2=\5&\4=\4\"\3B\1\2\0019\1\2\0009\1'\1'\3(\0005\4,\0009\5\20\0009\5\21\0054\a\3\0005\b)\0>\b\1\a4\b\3\0005\t*\0>\t\1\b4\t\3\0005\n+\0>\n\1\tB\5\4\2=\5\21\4B\1\3\0019\1\2\0009\1-\1'\3.\0005\4/\0009\5\3\0009\5\4\0059\5-\5B\5\1\2=\5\3\0044\5\3\0005\0060\0>\6\1\5=\5\21\4B\1\3\0019\1\2\0009\1-\1'\0031\0005\0042\0009\5\3\0009\5\4\0059\5-\5B\5\1\2=\5\3\0049\5\20\0009\5\21\0054\a\3\0005\b3\0>\b\1\a4\b\3\0005\t4\0>\t\1\bB\5\3\2=\5\21\4B\1\3\1K\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\1\0\1\tname\24conventionalcommits\14gitcommit\rfiletype\18documentation\15completion\1\0\0\rbordered\vwindow\15formatting\vformat\1\0\0\15cmp_format\flspkind\fsnippet\vexpand\1\0\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\1\0\0\t<CR>\1\0\1\vselect\1\fconfirm\f<S-Tab>\21select_prev_item\n<Tab>\21select_next_item\n<C-e>\nabort\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-code-action-menu"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-code-action-menu",
    url = "https://github.com/weilbith/nvim-code-action-menu"
  },
  ["nvim-hlslens"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\n¢\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\17virtual_text\1\0\2\ttext\bÔ†¥\fenabled\2\tsign\1\0\1\fenabled\1\fautocmd\1\0\0\1\0\1\fenabled\2\nsetup\19nvim-lightbulb\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nP\0\0\4\0\4\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n˚\5\0\0\6\0\29\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\3=\3\v\0025\3\14\0005\4\f\0005\5\r\0=\5\n\4=\4\15\0035\4\16\0005\5\17\0=\5\18\0045\5\19\0=\5\20\4=\4\21\0035\4\22\0005\5\23\0=\5\24\4=\4\25\3=\3\26\0025\3\27\0=\3\28\2B\0\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\16textobjects\16lsp_interop\25peek_definition_code\1\0\2\15<leader>df\20@function.outer\15<leader>dF\17@class.outer\1\0\2\venable\2\vborder\tnone\tswap\18swap_previous\1\0\1\14<leader>P\21@parameter.inner\14swap_next\1\0\1\14<leader>p\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\1\0\4\aif\20@function.inner\aaf\20@function.outer\aac\17@class.outer\aic\17@class.inner\1\0\2\venable\2\14lookahead\2\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\t<CR>\19init_selection\t<CR>\21node_decremental\f<S-TAB>\21node_incremental\n<TAB>\1\0\1\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\vindent\1\0\1\venable\2\1\0\1\17auto_install\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nÅ\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\5\vzindex\3\20\15trim_scope\nouter\14max_lines\3\5\venable\2\tmode\vcursor\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["syntax-tree-surfer"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/syntax-tree-surfer",
    url = "https://github.com/ziontee113/syntax-tree-surfer"
  },
  ["tabline-framework.nvim"] = {
    after = { "incline.nvim" },
    config = { "\27LJ\2\n´\5\0\1\16\6\27\0x+\1\0\0009\2\0\0\15\0\2\0X\3\3Ä-\2\0\0009\1\1\2X\2\2Ä-\2\1\0009\1\1\2-\2\2\0009\2\2\2\18\4\1\0B\2\2\1-\2\2\0009\2\3\0025\4\4\0-\5\3\0>\5\1\4=\1\5\4-\5\4\0009\5\1\5=\5\1\4B\2\2\1-\2\2\0009\2\3\0029\4\6\0'\5\a\0&\4\5\4B\2\2\0019\2\b\0\15\0\2\0X\3\fÄ-\2\2\0009\2\3\0029\4\t\0\15\0\4\0X\5\1Ä'\4\n\0B\2\2\1-\2\2\0009\2\3\0029\4\b\0B\2\2\1X\2\tÄ-\2\2\0009\2\3\0029\4\t\0\15\0\4\0X\5\2Ä'\4\v\0X\5\1Ä'\4\f\0B\2\2\0016\2\r\0006\4\14\0009\4\15\0049\4\16\0049\6\17\0B\4\2\0A\2\0\4X\5*Ä6\a\14\0009\a\15\a9\a\18\a\18\t\6\0B\a\2\0026\b\14\0009\b\15\b9\b\19\b\18\n\a\0B\b\2\2\14\0\b\0X\t\1Ä'\b\20\0\18\v\b\0009\t\21\b'\f\22\0B\t\3\2-\n\2\0009\n\23\n\18\f\t\0B\n\2\2-\v\2\0009\v\24\v\18\r\t\0B\v\2\2\n\n\0\0X\f\15Ä9\f\0\0\15\0\f\0X\r\6Ä\n\v\0\0X\f\4Ä-\f\2\0009\f\25\f\18\14\v\0B\f\2\1-\f\2\0009\f\3\f'\14\a\0\18\15\n\0&\14\15\14B\f\2\1E\5\3\3R\5‘\127-\2\2\0009\2\3\2'\4\a\0B\2\2\1-\2\2\0009\2\3\0025\4\26\0-\5\5\0>\5\1\4=\1\5\4-\5\4\0009\5\1\5=\5\1\4B\2\2\1K\0\1\0\2\0\3\0\0¿\4\0\1\0\5\0\1\0\0\vset_fg\15icon_color\ticon\14^.+/(.+)$\nmatch\5\22nvim_buf_get_name\21nvim_win_get_buf\btab\27nvim_tabpage_list_wins\bapi\bvim\vipairs\b[-]\b[+]\6+\rmodified\rfilename\6 \nindex\afg\1\0\0\badd\vset_bg\abg\fcurrento\1\1\5\6\a\0\0149\1\0\0005\3\1\0-\4\0\0009\4\2\4=\4\3\3-\4\1\0009\4\4\4=\4\4\3B\1\2\0019\1\5\0003\3\6\0B\1\2\0012\0\0ÄK\0\1\0\0¿\2¿\3¿\4¿\5¿\6¿\0\14make_tabs\abg\afg\tteal\1\2\0\0\n Ôß® \baddí\2\1\0\v\0\15\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0026\1\0\0'\3\3\0B\1\2\0029\2\4\1'\4\5\0B\2\2\0029\3\4\1'\5\6\0B\3\2\0029\4\4\1'\6\a\0B\4\2\2'\5\b\0'\6\t\0006\a\0\0'\t\n\0B\a\2\0029\a\v\a5\t\r\0003\n\f\0=\n\14\tB\a\2\0012\0\0ÄK\0\1\0\vrender\1\0\0\0\nsetup\22tabline_framework\bÓÇ¥\t ÓÇ∂\fTabLine\15TabLineSel\16TabLineFill\vget_hl!tabline_framework.highlights\16get_palette\24catppuccin.palettes\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/opt/tabline-framework.nvim",
    url = "https://github.com/rafcamlet/tabline-framework.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope-vimspector.nvim"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/telescope-vimspector.nvim",
    url = "https://github.com/nvim-telescope/telescope-vimspector.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nª\2\0\0\6\0\15\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\5\0005\5\4\0=\5\6\4=\4\a\3=\3\t\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\v\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\f\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\r\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\14\0B\0\2\1K\0\1\0\16media_files\vnotify\14ui-select\bfzf\19load_extension\rdefaults\1\0\0\18layout_config\tflex\1\0\0\1\0\1\17flip_columns\3»\1\1\0\2\20layout_strategy\tflex\rwinblend\3\n\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/rlabeyrie/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nè\2\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\17integrations\fneotree\1\0\0\1\0\3\22transparent_panel\1\14show_root\1\fenabled\2\1\0\5\31show_current_context_start\1\25show_current_context\2#show_trailing_blankline_indent\1\24max_indent_increase\3\1\19use_treesitter\2\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: catppuccin
time([[Config for catppuccin]], true)
try_loadstring("\27LJ\2\n∏\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\fcompile\1\0\1\fenabled\2\17integrations\1\0\0\fneotree\1\0\3\22transparent_panel\1\14show_root\2\fenabled\2\1\0\1\14telescope\2\nsetup\15catppuccin\frequire\0", "config", "catppuccin")
time([[Config for catppuccin]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n˚\5\0\0\6\0\29\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\3=\3\v\0025\3\14\0005\4\f\0005\5\r\0=\5\n\4=\4\15\0035\4\16\0005\5\17\0=\5\18\0045\5\19\0=\5\20\4=\4\21\0035\4\22\0005\5\23\0=\5\24\4=\4\25\3=\3\26\0025\3\27\0=\3\28\2B\0\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\16textobjects\16lsp_interop\25peek_definition_code\1\0\2\15<leader>df\20@function.outer\15<leader>dF\17@class.outer\1\0\2\venable\2\vborder\tnone\tswap\18swap_previous\1\0\1\14<leader>P\21@parameter.inner\14swap_next\1\0\1\14<leader>p\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\1\0\4\aif\20@function.inner\aaf\20@function.outer\aac\17@class.outer\aic\17@class.inner\1\0\2\venable\2\14lookahead\2\26incremental_selection\fkeymaps\1\0\4\22scope_incremental\t<CR>\19init_selection\t<CR>\21node_decremental\f<S-TAB>\21node_incremental\n<TAB>\1\0\1\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\vindent\1\0\1\venable\2\1\0\1\17auto_install\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: lsp_lines.nvim
time([[Config for lsp_lines.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lsp_lines\frequire\0", "config", "lsp_lines.nvim")
time([[Config for lsp_lines.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nª\2\0\0\6\0\15\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\5\0005\5\4\0=\5\6\4=\4\a\3=\3\t\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\v\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\f\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\r\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\n\0'\2\14\0B\0\2\1K\0\1\0\16media_files\vnotify\14ui-select\bfzf\19load_extension\rdefaults\1\0\0\18layout_config\tflex\1\0\0\1\0\1\17flip_columns\3»\1\1\0\2\20layout_strategy\tflex\rwinblend\3\n\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lightbulb
time([[Config for nvim-lightbulb]], true)
try_loadstring("\27LJ\2\n¢\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\17virtual_text\1\0\2\ttext\bÔ†¥\fenabled\2\tsign\1\0\1\fenabled\1\fautocmd\1\0\0\1\0\1\fenabled\2\nsetup\19nvim-lightbulb\frequire\0", "config", "nvim-lightbulb")
time([[Config for nvim-lightbulb]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: FixCursorHold.nvim
time([[Config for FixCursorHold.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1»\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0", "config", "FixCursorHold.nvim")
time([[Config for FixCursorHold.nvim]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nX\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23popup_border_style\frounded\nsetup\rneo-tree\frequire\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\5\vzindex\3\20\15trim_scope\nouter\14max_lines\3\5\venable\2\tmode\vcursor\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: guess-indent.nvim
time([[Config for guess-indent.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17guess-indent\frequire\0", "config", "guess-indent.nvim")
time([[Config for guess-indent.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire◊\a\1\0\v\0005\0Ä\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\19\0009\4\3\0009\4\4\0049\4\5\0045\6\a\0009\a\3\0009\a\6\a)\t¸ˇB\a\2\2=\a\b\0069\a\3\0009\a\6\a)\t\4\0B\a\2\2=\a\t\0069\a\3\0009\a\n\aB\a\1\2=\a\v\0069\a\3\0009\a\f\aB\a\1\2=\a\r\0069\a\3\0009\a\14\aB\a\1\2=\a\15\0069\a\3\0009\a\16\a5\t\17\0B\a\2\2=\a\18\6B\4\2\2=\4\3\0039\4\20\0009\4\21\0044\6\3\0005\a\22\0>\a\1\0065\a\23\0>\a\2\0064\a\3\0005\b\24\0>\b\1\aB\4\3\2=\4\21\0035\4\26\0003\5\25\0=\5\27\4=\4\28\0035\4\31\0006\5\0\0'\a\29\0B\5\2\0029\5\30\5B\5\1\2=\5 \4=\4!\0035\4$\0009\5\20\0009\5\"\0059\5#\5B\5\1\2=\5%\0049\5\20\0009\5\"\0059\5#\5B\5\1\2=\5&\4=\4\"\3B\1\2\0019\1\2\0009\1'\1'\3(\0005\4,\0009\5\20\0009\5\21\0054\a\3\0005\b)\0>\b\1\a4\b\3\0005\t*\0>\t\1\b4\t\3\0005\n+\0>\n\1\tB\5\4\2=\5\21\4B\1\3\0019\1\2\0009\1-\1'\3.\0005\4/\0009\5\3\0009\5\4\0059\5-\5B\5\1\2=\5\3\0044\5\3\0005\0060\0>\6\1\5=\5\21\4B\1\3\0019\1\2\0009\1-\1'\0031\0005\0042\0009\5\3\0009\5\4\0059\5-\5B\5\1\2=\5\3\0049\5\20\0009\5\21\0054\a\3\0005\b3\0>\b\1\a4\b\3\0005\t4\0>\t\1\bB\5\3\2=\5\21\4B\1\3\1K\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\1\0\1\tname\24conventionalcommits\14gitcommit\rfiletype\18documentation\15completion\1\0\0\rbordered\vwindow\15formatting\vformat\1\0\0\15cmp_format\flspkind\fsnippet\vexpand\1\0\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\1\0\0\t<CR>\1\0\1\vselect\1\fconfirm\f<S-Tab>\21select_prev_item\n<Tab>\21select_next_item\n<C-e>\nabort\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\24cwd_change_handling\1\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: inc-rename.nvim
time([[Config for inc-rename.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15inc_rename\frequire\0", "config", "inc-rename.nvim")
time([[Config for inc-rename.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nP\0\0\4\0\4\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nŸ\1\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\2B\0\2\1K\0\1\0\nsigns\1\0\0\17changedelete\1\0\1\ttext\b‚îÉ\14topdelete\1\0\1\ttext\b‚Äæ\vdelete\1\0\1\ttext\6_\vchange\1\0\1\ttext\b‚îÉ\badd\1\0\0\1\0\1\ttext\b‚îÉ\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd tabline-framework.nvim ]]

-- Config for: tabline-framework.nvim
try_loadstring("\27LJ\2\n´\5\0\1\16\6\27\0x+\1\0\0009\2\0\0\15\0\2\0X\3\3Ä-\2\0\0009\1\1\2X\2\2Ä-\2\1\0009\1\1\2-\2\2\0009\2\2\2\18\4\1\0B\2\2\1-\2\2\0009\2\3\0025\4\4\0-\5\3\0>\5\1\4=\1\5\4-\5\4\0009\5\1\5=\5\1\4B\2\2\1-\2\2\0009\2\3\0029\4\6\0'\5\a\0&\4\5\4B\2\2\0019\2\b\0\15\0\2\0X\3\fÄ-\2\2\0009\2\3\0029\4\t\0\15\0\4\0X\5\1Ä'\4\n\0B\2\2\1-\2\2\0009\2\3\0029\4\b\0B\2\2\1X\2\tÄ-\2\2\0009\2\3\0029\4\t\0\15\0\4\0X\5\2Ä'\4\v\0X\5\1Ä'\4\f\0B\2\2\0016\2\r\0006\4\14\0009\4\15\0049\4\16\0049\6\17\0B\4\2\0A\2\0\4X\5*Ä6\a\14\0009\a\15\a9\a\18\a\18\t\6\0B\a\2\0026\b\14\0009\b\15\b9\b\19\b\18\n\a\0B\b\2\2\14\0\b\0X\t\1Ä'\b\20\0\18\v\b\0009\t\21\b'\f\22\0B\t\3\2-\n\2\0009\n\23\n\18\f\t\0B\n\2\2-\v\2\0009\v\24\v\18\r\t\0B\v\2\2\n\n\0\0X\f\15Ä9\f\0\0\15\0\f\0X\r\6Ä\n\v\0\0X\f\4Ä-\f\2\0009\f\25\f\18\14\v\0B\f\2\1-\f\2\0009\f\3\f'\14\a\0\18\15\n\0&\14\15\14B\f\2\1E\5\3\3R\5‘\127-\2\2\0009\2\3\2'\4\a\0B\2\2\1-\2\2\0009\2\3\0025\4\26\0-\5\5\0>\5\1\4=\1\5\4-\5\4\0009\5\1\5=\5\1\4B\2\2\1K\0\1\0\2\0\3\0\0¿\4\0\1\0\5\0\1\0\0\vset_fg\15icon_color\ticon\14^.+/(.+)$\nmatch\5\22nvim_buf_get_name\21nvim_win_get_buf\btab\27nvim_tabpage_list_wins\bapi\bvim\vipairs\b[-]\b[+]\6+\rmodified\rfilename\6 \nindex\afg\1\0\0\badd\vset_bg\abg\fcurrento\1\1\5\6\a\0\0149\1\0\0005\3\1\0-\4\0\0009\4\2\4=\4\3\3-\4\1\0009\4\4\4=\4\4\3B\1\2\0019\1\5\0003\3\6\0B\1\2\0012\0\0ÄK\0\1\0\0¿\2¿\3¿\4¿\5¿\6¿\0\14make_tabs\abg\afg\tteal\1\2\0\0\n Ôß® \baddí\2\1\0\v\0\15\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0026\1\0\0'\3\3\0B\1\2\0029\2\4\1'\4\5\0B\2\2\0029\3\4\1'\5\6\0B\3\2\0029\4\4\1'\6\a\0B\4\2\2'\5\b\0'\6\t\0006\a\0\0'\t\n\0B\a\2\0029\a\v\a5\t\r\0003\n\f\0=\n\14\tB\a\2\0012\0\0ÄK\0\1\0\vrender\1\0\0\0\nsetup\22tabline_framework\bÓÇ¥\t ÓÇ∂\fTabLine\15TabLineSel\16TabLineFill\vget_hl!tabline_framework.highlights\16get_palette\24catppuccin.palettes\frequire\0", "config", "tabline-framework.nvim")

vim.cmd [[ packadd incline.nvim ]]

-- Config for: incline.nvim
try_loadstring("\27LJ\2\nê\6\0\1\21\5!\2Å\0016\1\0\0009\1\1\0019\1\2\0016\3\0\0009\3\3\0039\3\4\0039\5\5\0B\3\2\2'\4\6\0B\1\3\2\18\4\1\0009\2\a\1'\5\b\0B\2\3\0026\3\t\0'\5\n\0B\3\2\0029\3\v\3\18\5\1\0\18\6\2\0B\3\3\0035\5\f\0=\4\r\5-\6\0\0009\6\14\6\18\b\4\0*\t\0\0B\6\3\2=\6\15\5-\6\1\0009\a\16\0\15\0\a\0X\b\1Ä-\6\2\0004\a\5\0005\b\17\0009\t\15\5=\t\18\b-\t\3\0009\t\15\t=\t\19\b>\b\1\a5\b\21\0\18\t\3\0'\n\20\0&\t\n\t>\t\1\b9\t\r\5=\t\18\b9\t\15\5=\t\19\b>\b\2\a5\b\22\0009\t\15\6=\t\18\b9\t\15\5=\t\19\b>\b\3\a4\b\3\0>\1\1\b>\b\4\a6\b\0\0009\b\23\b9\b\24\b9\n\5\0B\b\2\0025\t\25\0006\n\26\0\18\f\b\0B\n\2\4X\r\5Ä9\15\27\0149\16\27\0148\16\16\t\22\16\1\16<\16\15\tE\r\3\3R\r˘\127\18\n\6\0)\v\1\0)\f\4\0)\r\1\0M\v#Ä8\15\14\t)\16\0\0\1\16\15\0X\15\30Ä6\15\28\0009\15\29\15\18\17\a\0005\18\30\0009\19\15\n=\19\18\18-\19\4\0008\19\14\0199\19\15\19=\19\19\18B\15\3\0016\15\28\0009\15\29\15\18\17\a\0005\18\31\0'\19\20\0008\20\14\t&\19\20\19>\19\1\18-\19\4\0008\19\14\0199\19\r\19=\19\18\18-\19\4\0008\19\14\0199\19\15\19=\19\19\18B\15\3\1-\15\4\0008\n\14\15O\v›\1276\v\28\0009\v\29\v\18\r\a\0005\14 \0009\15\15\n=\15\18\14-\15\3\0009\15\15\15=\15\19\14B\v\3\1L\a\2\0\1¿\2¿\3¿\4¿\5¿\1\2\0\0\bÓÇ¥\1\0\0\1\2\0\0\bÓÇ¥\vinsert\ntable\rseverity\vipairs\1\5\0\0\3\0\3\0\3\0\3\0\bget\15diagnostic\1\2\0\0\bÓÇ∂\1\0\0\6 \nguibg\nguifg\1\2\0\0\bÓÇ∂\ffocused\abg\vdarken\afg\1\0\0\20get_icon_colors\22nvim-web-devicons\frequire\15^.+%.(.+)$\nmatch\a:.\bbuf\22nvim_buf_get_name\bapi\16fnamemodify\afn\bvimÁÃô≥\6≥ÊÃ˛\3\2…\4\1\0\f\0\26\00146\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0'\4\4\0B\2\2\0029\3\3\0'\5\5\0B\3\2\0029\4\3\0'\6\6\0B\4\2\0024\5\5\0009\6\3\0'\b\a\0B\6\2\2>\6\1\0059\6\3\0'\b\b\0B\6\2\2>\6\2\0059\6\3\0'\b\t\0B\6\2\2>\6\3\0059\6\3\0'\b\n\0B\6\2\0?\6\0\0006\6\0\0'\b\v\0B\6\2\0029\6\f\0065\b\14\0003\t\r\0=\t\15\b5\t\16\0005\n\17\0=\n\18\t5\n\20\0005\v\19\0=\v\21\n5\v\22\0=\v\23\n=\n\24\t=\t\25\bB\6\2\0012\0\0ÄK\0\1\0\vwindow\vmargin\rvertical\1\0\2\btop\3\0\vbottom\3\1\15horizontal\1\0\0\1\0\2\tleft\3\1\nright\3\1\14placement\1\0\2\rvertical\btop\15horizontal\nright\1\0\1\fpadding\3\0\vrender\1\0\0\0\nsetup\fincline\30DiagnosticVirtualTextHint\30DiagnosticVirtualTextInfo\30DiagnosticVirtualTextWarn\31DiagnosticVirtualTextError\vNormal\18InclineNormal\20InclineNormalNC\vget_hl\28catppuccin.utils.colors!tabline_framework.highlights\frequire\tÄÄ¿ô\4\0", "config", "incline.nvim")

vim.cmd [[ packadd feline.nvim ]]

-- Config for: feline.nvim
try_loadstring("\27LJ\2\nî\1\0\0\6\0\a\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\0\0'\3\3\0B\1\2\0029\1\2\0015\3\5\0009\4\4\0B\4\1\2=\4\6\3B\1\2\1K\0\1\0\15components\1\0\0\bget\vfeline\nsetup*catppuccin.groups.integrations.feline\frequire\0", "config", "feline.nvim")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
