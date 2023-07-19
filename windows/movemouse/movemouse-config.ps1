$GITHUB_USER = "sw3103"
$GITHUB_REPOSITORY = "movemouse"
$INSTALL_PATH = ""

$LatestRelease = @{
  "URI" = "https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPOSITORY/releases/latest"
  "Method" = "Get"
} ; Invoke-RestMethod @LatestRelease




