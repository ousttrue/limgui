import shutil
import platform
import os
import io
from invoke import task, Context
import pathlib

HERE = pathlib.Path(__file__).absolute().parent
BUILD_DIR = HERE / 'build'

# luajitffi
LUAJITFFI_DIR = HERE / '_external/luajitffi'
LUAJIT_DIR = LUAJITFFI_DIR / 'LuaJIT/src'
LUA_BIN = LUAJIT_DIR / 'luajit.exe'

# lua
IMGUI_FFI_DIR = HERE / 'lua/imgui_ffi'

VCVARS_BAT = pathlib.Path(
    "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat"
)


def get_cmake() -> pathlib.Path:
    if platform.system() == "Windows":
        for p in os.environ['PATH'].split(';'):
            if p:
                p = pathlib.Path(p)
                if p.exists():
                    cmake = p / 'cmake.exe'
                    if cmake.exists():
                        return cmake

        cmake = pathlib.Path("C:/Program Files/CMake/bin/cmake.exe")
        if cmake.exists():
            return cmake

        raise FileNotFoundError('cmake.exe')

    else:
        raise NotImplementedError()


def commandline(exe: pathlib.Path, *args: str):
    cmd = str(exe)
    if ' ' in cmd:
        cmd = f'"{cmd}"'
    return f'{cmd} {" ".join(args)}'


@task
def clean(c):
    # type: (Context) -> None
    '''
    remove build
    '''
    shutil.rmtree(BUILD_DIR)


@task
def build_lua(c):
    # type: (Context) -> None
    '''
    build luajit in luajitffi
    '''
    if not VCVARS_BAT.exists():
        raise Exception('no vcvars64.bat')

    with c.cd(LUAJIT_DIR):
        c.run(f'{os.environ["COMSPEC"]} /K "{VCVARS_BAT}"',
              in_stream=io.StringIO("msvcbuild.bat\r\nexit\r\n')"))


@task
def build(c):
    # type: (Context) -> None
    '''
    build glfw, imgui, luv
    '''
    cmake = get_cmake()
    BUILD_DIR.mkdir(exist_ok=True)
    with c.cd(BUILD_DIR):
        c.run(f'{os.environ["COMSPEC"]} /K "{VCVARS_BAT}"',
              in_stream=io.StringIO("cmake -B . -S ..\r\nexit\r\n')"))
        c.run(commandline(cmake, '--build', '.', '--config', 'Release'))


@task
def generate_ffi(c):
    # type: (Context) -> None
    '''
    build
    '''
    with c.cd(LUAJITFFI_DIR):
        c.run(commandline(LUA_BIN, "main.lua",
                          f"-E{HERE}/_external/imgui/imgui/imgui.h,ImGui.dll",
                          f"-O{IMGUI_FFI_DIR}"),
              env={
                  'PATH': f"{os.environ['PATH']};C:\\Program Files\\LLVM\\bin",
        })
