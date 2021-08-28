# limgui
luajit + ffi + imgui

* lua/imgui_ffi/mod.lua

# build dll

```
invoke build-all
```

# directory

## _external

submodules

### glfw
### imgui

### luajitffi

* generate imgui_ffi
* generate gl_ffi

### luv

build `invoke build-luv`

* `build/Release/luajit.exe`
* `build/Release/luv.dll`

## lua

lua libraries. add `LUA_PATH`

## tests

luaunit.lua
