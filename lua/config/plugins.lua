return
{
	{"windwp/nvim-autopairs", config=true},
	{"lewis6991/gitsigns.nvim", config=true},
	{"nvim-treesitter/nvim-treesitter",
		build=":TSUpdate",
		config=function()
			require("nvim-treesitter.configs").setup({
				highlight={enable=true},
                indent={enable=true},
				})
			end,
	},
    {"Diogo-ss/42-header.nvim",
        cmd = { "Stdheader" },
        keys = { "<F1>" },
        opts = {
        default_map = true, -- Default mapping <F1> in normal mode.
        auto_update = true, -- Update header when saving.
        user = "tafujise", -- Your user.
        mail = "tafujise@student.42jp", -- Your mail.
        },
  config = function(_, opts)
    require("42header").setup(opts)
  end,
    },
    {"bluz71/vim-moonfly-colors",
            name="moonfly",
            lazy=false,
            priority=1000,
            config=function()
				vim.g.moonflyTransparent=true
                vim.g.moonflyCursorColor=true
                vim.cmd("colorscheme moonfly")
            end,
    },
    {"romgrk/barbar.nvim",
        dependencies={
                "lewis6991/gitsigns.nvim",
                "nvim-tree/nvim-web-devicons",
            },
            init=function()
                vim.g.barbar_auto_setup=false
            end,
        opts = {
            animation = true,
            icons = {
            filetype = { enabled = true },
			-- separator={left='|', right='|'},
            buffer_index = true,
			button = 'X',
            modified = { button = '●' },
            pinned = { button = '' },
            },
        },
        version='^1.0.0',
    },
    {"akinsho/toggleterm.nvim",
        version="*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-\>]],
                direction = "float",
					float_opts = {
						border = "curved",
						winblend = 3,
						width= function()
							return math.floor(vim.o.columns * 0.7)
						end,
						height = function()
							return math.floor(vim.o.lines * 0.4)
						end,
					}
            })
			vim.keymap.set("n", "<C-\\>", function()
				local dir = vim.fn.expand("%:p:h")
				require("toggleterm").toggle(0, "float", dir)
			end, {noremap=true, silent=true, desc="ToggleTerm current dir"})
            -- Lazygitの設定
            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
				dir = "git_dir",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved", -- 枠線を丸くする
                    width = function()
						return math.floor(vim.o.columns * 0.9)    -- 最大幅
					end,
                    height = function()
						return math.floor(vim.o.lines * 0.9)   -- 最大高さ
					end,
                },
                on_open = function(_)
                    vim.cmd("startinsert!") -- 開いたらすぐ操作可能にする
                end,
                on_close = function(_)
                    vim.cmd("startinsert!")
                end,
            })

            -- トグル用の関数を定義
            function _lazygit_toggle()
                lazygit:toggle()
            end

            -- キーマッピングを設定 (leader + lg)
            vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
        end
    },
    -- {"nvim-telescope/telescope.nvim",
    --     dependencies={"nvim-lua/plenary.nvim"},
    --     cmd="Telescope",
    --     keys={
    --         -- {"<leader>ff", "<cmd>Telescope find_files<cr>", desc="Find files"},
    --         -- {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc="Live grep"},
    --     },
    --     opts={
    --         defaults={
    --             prompt_prefix="> ",
    --             selection_prefix="> ",
    --             sorting_strategy="ascending",
    --             layout_strategy="horizontal",
    --             layout_config={width=0.9, height=0.8},
    --         },
    --     },
    -- },
    {"neovim/nvim-lspconfig",
        tag = "v0.1.8",
        config = function()
            local lspconfig = require("lspconfig")
            -- 1. Lua LSの設定 (vim変数を認識させる)
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            lspconfig.lua_ls.setup({
                capabilities=capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
            -- 2. C/C++ (clangd) の設定
            lspconfig.clangd.setup({capabilities=capabilities})

            -- 3. Go (gopls) の設定
            lspconfig.gopls.setup({capabilities=capabilities})

            -- 3. エラー表示の見た目設定
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '✖ '
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
	{
  		'stevearc/oil.nvim',
  		---@module 'oil'
  		---@type oil.SetupOpts
  		opts = {
				default_file_explorer = true,
				columns={
					"icon",
				},
				buf_options={
					buflisted=false,
					bufhidden="hide",
				},
				lsp_file_methods={
					enabled=true,
					timeout_ms=1500,
					autosave_changes=false,
				},
				constrain_cursor="editable",
				watch_for_changes=true, -- cpu resource heavy
			},
  		lazy = false,
	},
	{"folke/noice.nvim",
			event="VeryLazy",
			opts={
				cmdline={
					format={
						cmdline={icon=">"},
						search_down={icon="/?"},
						search_up={icon="?"},
						filter={icon="$"},
						lua={icon="lua"},
						help={icon="?"},
					}
				},
				popupmenu={
					kind_icons=false,
					enabled=true,
					backend="cmp",
				},
				views={
					notify={
						background_colour="#1F2328",
					},
				},

			},
			dependencies={
				{"MunifTanjim/nui.nvim", pin=true},
				{
					"rcarriga/nvim-notify",
					opts = { background_colour = "#1F2328" },
				},
			},
	},
	{"rainbowhxch/accelerated-jk.nvim",
		opts={},
		keys={
				{"j", "<Plug>(accelerated_jk_gj)"},
				{"k", "<Plug>(accelerated_jk_gk)"},
			},
	},
	{
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        keys = {
            { "<leader>ff", function() require("snacks").picker.files({cwd=vim.fn.expand("%:p:h")})    end, desc = "Find files" },
            { "<leader>fg", function() require("snacks").picker.grep({cwd=vim.fn.expand("%:p:h")})     end, desc = "Live grep" },
            { "<leader>fb", function() require("snacks").picker.buffers()  end, desc = "Buffers" },
            { "<leader>fr", function() require("snacks").picker.recent()   end, desc = "Recent files" },
			{ "<leader>fp", function() require("snacks").picker.projects()   end, desc = "Projects(Oil)"},
            { "<leader>fe", function() require("snacks").picker.explorer({cwd=vim.fn.expand("%:p:h")}) end, desc = "Explorer" },
			{ "<leader>gd", function() require("snacks").picker.git_diff()  end, desc = "Git Diff (Hunks)"},
			{ "gd", function() require("snacks").picker.lsp_definitions()  end, desc = "Goto Definition"},
			{ "gI", function() require("snacks").picker.lsp_implementations()  end, desc = "Goto Implementation"},
        },
        ---@type snacks.Config
        opts = {
        	picker = {
            	sources = {
                	projects = {
                    	dev = {
                        	"~/",
                        	"~/Cursus",
                        	"~/Road",
                        	"~/Documents",
                    	},
						confirm=function(picker, item, action)
							picker:close()
							if not item or not item.file then
								return
							end

							local dir = item.file
							vim.cmd("cd " .. vim.fn.fnameescape(dir))
							require("oil").open(dir)
						end,
                	},
            	},
            	layout = { preset = "vertical" },
        	},
        	    dashboard = {
                enabled = false,
                row = 10,
                preset = {
                    keys = {
                        { icon = "", key = "r", desc = "recent",
								action = function() require("snacks").picker.recent()   end },
						{ icon = "", key = "p", desc = "projects",
								action = function() require("snacks").picker.projects()  end},
        				-- { icon = "", key = "f", desc = "files",
								-- action = function() require("snacks").picker.files({cwd=vim.fn.expand("%:p:h")})    end },
                        -- { icon = "", key = "g", desc = "grep",
								-- action = function() require("snacks").picker.grep({cwd=vim.fn.expand("%:p:h")})     end },
                        { icon = "", key = "e", desc = "explorer",
								action = function() require("snacks").picker.explorer({cwd=vim.fn.expand("%:p:h")}) end },
                        { icon = "", key = "q", desc = "quit",
								action = ":qa" },
                    },
                },
            },

        },
    },
	-- {"nvim-tree/nvim-tree.lua",
	-- 		version="*",
	-- 		lazy=false,
	-- 		dependencies={
	-- 			"nvim-tree/nvim-web-devicons",
	-- 		},
	-- 		keys={
	-- 			{mode="n", "<C-n>", "<cmd>NvimTreeToggle<CR>", desc="NvimTree Toggle"},
	-- 			{mode="n", "<C-m>", "<cmd>NvimTreeFocus<CR>", desc="NvimTree Focus"},
	-- 		},
	-- 		config=function()
	-- 			require("nvim-tree").setup{
	-- 				update_focused_file={
	-- 					enable=true,
	-- 					update_root=true,
	-- 					ignore_list={},
	-- 				},
	-- 				git={
	-- 					enable=true,
	-- 					ignore=true,
	-- 				},
	-- 				view={
	-- 					width=30,
	-- 					side="left",
	-- 				},
	-- 				renderer={
	-- 					group_empty=true,
	-- 					highlight_git=true,
	-- 					highlight_opened_files="all",
	-- 				},
	-- 				filters={
	-- 					dotfiles=true,
	-- 				},
	-- 			}
	-- 		end,
	-- },
	{"saghen/blink.cmp",
		version="*",
		opts={
			keymap={
				preset="super-tab",
				["<C-u>"]={"scroll_documentation_up","fallback"},
				["<C-d>"]={"scroll_documentation_down","fallback"},
				["<C-b>"]={},
				["<C-f>"]={},
			},
			sources={
				default={"lsp","path","buffer"},
			},
		},
	},
	{"stevearc/conform.nvim",
		event="BufWritePre",
		opts={
			formatters_by_ft={
				c={"c_formatter_42"},
				cpp={"clang_format"},
				go={"goimports"},
			},
			formatters={
				clang_format={
					prepend_args={"--style=Google"},
				},
			},
			format_on_save={
				timeout_ms=500,
				lsp_fallback=false,
			},
		},
	},
	{"numToStr/Comment.nvim",
			opts={
			}
	},
	{"folke/which-key.nvim",
		event="VeryLazy",
		opts={},
		keys={
			{
				"<leader>?",
				function()
					require("which-key").show({global=false})
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{"sarrisv/readermode.nvim",
		opts={
				enabled=false,
				keymap="<Leader>R",
			},
	},
}
