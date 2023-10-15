Write-Host "Importing the file " -NoNewline
Write-Host $(( $MyInvocation.MyCommand.Definition ).Split("\")[-1]) -ForegroundColor Green

$Module = @{
  "Terminal-Icons" = "Latest"
}

if ($Module.Values -eq "Latest") {
  try {
    Import-Module -Name $Module.Keys -ErrorAction Stop
  }
  catch {
    Write-Host "  | Could not find module $($Module.Keys)"
    Write-Host "  | Attempting to install $($Module.Keys)"
    Install-Module -Name "Terminal-Icons" -Repository PSGallery -Force
    Write-Host "  | Successfully installed module $($Module.Keys)"
    try {
      Import-Module -Name $Module.Keys -Force -ErrorAction Stop 
    }
    catch {
      Write-Host "  | Could not import the newly installed module $($Module.Keys)"
    }
  }
} 

else {
  [Microsoft.PowerShell.Commands.ModuleSpecification]$ModuleSpecification = @{
    "ModuleName" = $Module.Keys
    "ModuleVersion" = $Module.Values
  }
  
  if (Get-Module -ListAvailable | Where-Object {( $_.Name -eq $ModuleSpecification.Name ) -and ($_.Version -eq $ModuleSpecification.Version)}) {
    Import-Module -FullyQualifiedName $ModuleSpecification
    Write-Host "Module " -NoNewline
    Write-Host $($ModuleSpecification.Name) -ForegroundColor Green -NoNewline
    Write-Host ", version " -NoNewline
    Write-Host $($ModuleSpecification.Version) -ForegroundColor Green -NoNewline
    Write-Host " was imported."
  } 
  
  else {
    Write-Host "Module " -NoNewline
    Write-Host $($ModuleSpecification.Name) -ForegroundColor Red -NoNewline
    Write-Host ", version " -NoNewline
    Write-Host $($ModuleSpecification.Version) -ForegroundColor Red -NoNewline
    Write-Host " was not imported."
  }
}
