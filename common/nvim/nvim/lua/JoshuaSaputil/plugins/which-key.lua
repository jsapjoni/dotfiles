local status, whichkey = pcall(require, "whichkey")
if not status then
	return
end

whichkey.setup({})
