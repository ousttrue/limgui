from invoke import task, Context
import pathlib
HERE =pathlib.Path(__file__).absolute().parent
import os
import platform
import shutil

GLFW_DIR = HERE / 'libs/glfw'
GLFW_BUILD_DIR = GLFW_DIR / 'build'

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
    '''
    build libs/glfw/build/src/Release/glfw3.dll
    '''
    cmake = get_cmake()
    GLFW_BUILD_DIR.mkdir(exist_ok=True)
    with c.cd(GLFW_BUILD_DIR):
        c.run(commandline(cmake, '-DBUILD_SHARED_LIBS=1', '-DGLFW_BUILD_EXAMPLES=0', '-DGLFW_BUILD_TESTS=0', '..'))
        c.run(commandline(cmake, '--build', '.', '--config', 'Release'))

@task
def clean(c):
    '''
    remove libs/glfw/build
    '''
    shutil.rmtree(GLFW_BUILD_DIR)

@task
def hererocks(c):
    '''
    build lua
    '''
    c.run('hererocks -j 2.1.0-beta3 -r latest lua')

@task(build_glfw, hererocks)
def all(c):
    '''
    build all
    '''
    pass
