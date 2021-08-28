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

# directory

## _external

submodules. build to `build/Release/bin`

### glfw

* glad.dll
* glfw3.dll

### imgui

* imgui.dll

### luv

* luajit.exe
* luv.dll

### luajitffi
lua utility.

* generate imgui_ffi
* generate gl_ffi


## lua

```json
"env": {
    "LUA_PATH": ";;${workspaceFolder}\\lua\\?.lua",
}
```
## tests

luaunit.lua
