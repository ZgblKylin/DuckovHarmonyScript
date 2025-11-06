# 需要开启PowerShell脚本执行权限
# PowerShell script execution policy needs to be enabled
# 方法一：系统设置-高级-Powershell-允许本地PowerShell脚本执行
# Method 1: System Settings - Advanced - Powershell - Allow local Powershell script execution
# 方法二：在Powershell中执行命令：Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Method 2: Execute the command in Powershell: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# 若本脚本为网络下载，则需要在文件属性中解除阻止
# If this script is downloaded from the internet, you need to unblock it in the file properties

$HarmonyMod = 3589088839
$HarmonyModPath = Join-Path -Path (Get-Location) -ChildPath $HarmonyMod

# 遍历当前目录中的所有文件夹
# Iterate through all folders in the current directory
forEach ($folder in Get-ChildItem -Directory) {
  if ($folder.Name -ne $HarmonyMod) {
    # 若果文件夹中包含0Harmony.dll
    # If folder contains 0Harmony.dll
    if (Test-Path "$($folder.FullName)\0Harmony.dll") {
      # 从info.ini文件中读取mod名称
      # Read mod name from info.ini file
      $infoFilePath = "$($folder.FullName)\info.ini"
      $modName = ""
      $modDisplayName = ""
      if (Test-Path $infoFilePath) {
        # read all lines
        $infoLines = Get-Content $infoFilePath
        foreach ($line in $infoLines) {
          if ($line -match '^\s*name\s*=\s*(.+)$') {
            $modName = $Matches[1].Trim()
          }
          if ($line -match '^\s*displayName\s*=\s*(.+)$') {
            $modDisplayName = $Matches[1].Trim()
          }
        }
      }
      $prefix = ""
      if ($modName -ne "") {
        $prefix = "[$modName] "
      }
      if ($modDisplayName -ne "") {
        $prefix += "[$modDisplayName] "
      }
      # 检查0Harmony.dll是否不是符号链接
      # Check if 0Harmony.dll is not a symlink
      $fileInfo = Get-Item "$($folder.FullName)\0Harmony.dll"
      if (-not $fileInfo.Attributes.ToString().Contains("ReparsePoint")) {
        # 删除0Harmony.dll
        Write-Host $prefix"Removing 0Harmony.dll from $($folder.Name)"
        Remove-Item "$($folder.FullName)\0Harmony.dll" -Force
        # 创建指向Harmony mod文件夹的符号链接
        # Create symlink to the Harmony mod folder
        New-Item -ItemType SymbolicLink -Path "$($folder.FullName)\0Harmony.dll" -Target "$HarmonyModPath\0Harmony.dll"
      }
      else {
        # 已经是符号链接则跳过
        Write-Host $prefix"0Harmony.dll in $($folder.Name) is already a symlink. Skipping..."
      }
    }
  }
}
