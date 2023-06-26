local setup, surround = pcall(require, "surround")
if not setup then
  return
end

surround.setup({
  mappings_style = "surround"
})
