:: Be like the Developer Command Prompt for VS 2017
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Tools\VsDevCmd.bat"

:: ---------------------------------------------------------------------------------------
:: UrhoSharp.SharpReality
:: ---------------------------------------------------------------------------------------
call MakeSharpRealityThreaded.bat x86 Debug 2017
call MakeSharpRealityThreaded.bat x64 Debug 2017

msbuild Urho3D\Urho3D_SharpReality\UrhoSharp.SharpReality\UrhoSharp.SharpReality.vcxproj /p:Configuration=Debug /p:Platform=Win32
msbuild Urho3D\Urho3D_SharpReality\UrhoSharp.SharpReality\UrhoSharp.SharpReality.vcxproj /p:Configuration=Debug /p:Platform=x64

msbuild /t:restore Bindings\SharpReality\Urho.SharpReality.csproj
msbuild Bindings\SharpReality\Urho.SharpReality.csproj /p:Configuration=Debug /p:Platform=AnyCPU

:: ---------------------------------------------------------------------------------------
:: Create NuGet packages
:: ---------------------------------------------------------------------------------------
set URHO_NUGET_VER="1.8.91-local-debug-threaded"
nuget pack Nuget\Urho.SharpReality-Debug.nuspec -Version %URHO_NUGET_VER%

:: Leave the Command Prompt open
pause