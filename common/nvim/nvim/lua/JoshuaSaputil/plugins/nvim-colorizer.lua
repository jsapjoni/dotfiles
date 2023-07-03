local colorizer_setup, colorizer = pcall(require, "nvim-colorizer")
if not colorizer_setup then
	return
end

colorizer.setup()
