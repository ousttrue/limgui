import shutil
import platform
import os
import io
from invoke import task, Context
import pathlib
HERE = pathlib.Path(__file__).absolute().parent
# libs
GLFW_DIR = HERE / 'libs/glfw'
GLFW_BUILD_DIR = GLFW_DIR / 'build'
LIBS_DIR = HERE / 'libs'
LIBS_BUILD_DIR = HERE / 'libs/build'
# luajitffi
LUAJITFFI_DIR = HERE / 'luajitffi'
LUAJIT_DIR = LUAJITFFI_DIR / 'LuaJIT/src'
LUA_BIN = LUAJIT_DIR / 'luajit.exe'
# lua
IMGUI_FFI_DIR = HERE / 'lua/imgui_ffi'


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
def build_glfw(c):
    # type: (Context) -> None
    '''
    build libs/glfw/build/src/Release/glfw3.dll
    '''
    cmake = get_cmake()
    GLFW_BUILD_DIR.mkdir(exist_ok=True)
    with c.cd(GLFW_BUILD_DIR):
        c.run(commandline(cmake, '-DBUILD_SHARED_LIBS=1',
              '-DGLFW_BUILD_EXAMPLES=0', '-DGLFW_BUILD_TESTS=0', '..'))
        c.run(commandline(cmake, '--build', '.', '--config', 'Release'))
        # fix
        shutil.copy((GLFW_BUILD_DIR / 'src/Release/glfw3dll.exp'),
                    (GLFW_BUILD_DIR / 'src/Release/glfw3.exp'))
        shutil.copy((GLFW_BUILD_DIR / 'src/Release/glfw3dll.lib'),
                    (GLFW_BUILD_DIR / 'src/Release/glfw3.lib'))


@task
def build_imgui(c):
    # type: (Context) -> None
    '''
    build libs/build/Release/glad.dll
    build libs/build/Release/imgui.dll
    '''
    cmake = get_cmake()
    LIBS_BUILD_DIR.mkdir(exist_ok=True)
    with c.cd(LIBS_BUILD_DIR):
        c.run(commandline(cmake, '..'))
        c.run(commandline(cmake, '--build', '.', '--config', 'Release'))


@task
def clean(c):
    # type: (Context) -> None
    '''
    remove libs/glfw/build
    '''
    shutil.rmtree(GLFW_BUILD_DIR)


@task
def build_lua(c):
    # type: (Context) -> None
    '''
    build lua
    '''
    with c.cd(LUAJIT_DIR):
        c.run(f'{os.environ["COMSPEC"]} /K "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat"',
              in_stream=io.StringIO("msvcbuild.bat\r\nexit\r\n')"))


@ task(build_glfw, build_imgui, build_lua)
def build_all(c):
    # type: (Context) -> None
    '''
    build all
    '''
    print('build all')


@ task
def generate_ffi(c):
    # type: (Context) -> None
    '''
    build
    '''
    with c.cd(LUAJITFFI_DIR):
        c.run(commandline(
            LUA_BIN,
            "main.lua",
            f"-E{IMGUI_DIR}/imgui.h,ImGui.dll",
            f"-O{IMGUI_FFI_DIR}"
        ), env={
            'PATH': f"{os.environ['PATH']};C:\\Program Files\\LLVM\\bin",
        })
