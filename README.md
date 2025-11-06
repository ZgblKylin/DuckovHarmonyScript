# DuckovHarmonyScript
Replace mods embedded 0Harmony.dll to symbol link to Harmony mod.

## Usage
Put `harmony.ps1` in Duckov mod folder(`<Steam Installation>\steamapps\workshop\content\3167020`), then execute it.

## Note
PowerShell script execution policy needs to be enabled.
It could be enabled via:
1. Permanent: System Settings - Advanced - Powershell - Allow local Powershell script execution.
2. Temporary: Execute the command in Powershell: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
**MAKE SURE** unblock the script in the file properties if it's downloaded from browser.

----

将模组中内嵌的0Harmony.dll替换为指向Harmony模组的符号链接。

## 用法
将`harmony.ps1`放置在鸭科夫模组根目录(`<Steam Installation>\steamapps\workshop\content\3167020`)，然后执行脚本。

## 注意
需要启用Powershell脚本执行权限，可以通过以下方式启用：
1. 永久：系统设置-高级-Powershell-允许本地PowerShell脚本执行
2. 临时：在Powershell中执行命令：`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
如果脚本文件是从浏览器下载的，需要**确保**在文件属性中解除锁定。
