# limgui
luajit + ffi + imgui

* lua/imgui_ffi/mod.lua

* 20210828: fix native module build

# build dll

create release build to `build/Release/bin`

```
$ mkdir build
$ cd build
$ cmake -B . -S ..
$ cmake --build . --config Release
```

or

```
$ invoke build
```

clear: remove build folder.

## build/Release/bin

* glad.dll
* glfw3.dll
* imgui.dll
* luajit.exe
* luv.dll

# directory

## _external

submodules. build to `build/Release/bin`

## lua

```json
"env": {
    "LUA_PATH": ";;${workspaceFolder}\\lua\\?.lua",
}
```
## tests

luaunit.lua

## samples

### gltf_viewer.lua

* [ ] texture load
* [ ] MikkTangent
* [ ] GRID gizmo
* [ ] glTF-2.0 PBR shader
* [ ] animation
* [ ] skinning
* [ ] morph-target
