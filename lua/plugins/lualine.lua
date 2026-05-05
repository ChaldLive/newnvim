return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		-- Catppuccin macchiato palette
		local colors = {
			clean = { fg = "#181926", bg = "#a6da95" }, -- crust on green
			modified = { fg = "#181926", bg = "#eed49f" }, -- crust on yellow
			dirty = { fg = "#cad3f5", bg = "#ed8796" }, -- text on red
			staged = { fg = "#181926", bg = "#c6a0f6" }, -- crust on mauve
			none = { fg = "#cad3f5", bg = "#5b6078" }, -- text on surface2
		}

		-- Determine Git color based on gitsigns status
		local function git_status_color()
			local g = vim.b.gitsigns_status_dict
			if not g or not g.head then
				return colors.none
			end

			local added = g.added or 0
			local changed = g.changed or 0
			local removed = g.removed or 0

			-- Clean repo
			if added == 0 and changed == 0 and removed == 0 then
				return colors.clean
			end

			-- Modified files
			if changed > 0 then
				return colors.modified
			end

			-- Added/removed only → staged-ish
			if added > 0 or removed > 0 then
				return colors.staged
			end

			-- Fallback dirty
			return colors.dirty
		end

		-- Branch name with icon
		local function git_branch()
			local g = vim.b.gitsigns_status_dict
			if not g or not g.head or g.head == "" then
				return ""
			end
			return " " .. g.head
		end

		require("lualine").setup({
			options = {
				theme = "catppuccin-macchiato",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				icons_enabled = true,
			},

			sections = {
				lualine_a = { "mode" },

				lualine_b = {
					{
						git_branch,
						color = git_status_color,
						separator = { left = "", right = "" }, -- restores arrowheads
						padding = { left = 1, right = 1 },
					},
					"diff",
					"diagnostics",
				},

				lualine_c = {
					{ "filename", path = 1 },
				},

				lualine_x = { "encoding", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

			extensions = { "quickfix", "lazy" },
		})
	end,
}
