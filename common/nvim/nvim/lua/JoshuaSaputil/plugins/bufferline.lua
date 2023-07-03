local bufferline_status, bufferline = pcall(require, "bufferline")
if not bufferline_status then
	return
end

bufferline.setup({
	options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				padding = 1,
			},
		},
	},
})
