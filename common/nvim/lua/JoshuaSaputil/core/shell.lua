local opt = vim.opt

opt.shell = "pwsh"
opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
