# project
CMAKE_MINIMUM_REQUIRED(VERSION 3.20.0)
PROJECT(imgui VERSION 0.1.0)

#
# imgui
#
SET(TARGET_NAME imgui)
SET(SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/../imgui)
SET(GLFW_DIR ${CMAKE_CURRENT_LIST_DIR}/../glfw)
ADD_LIBRARY(${TARGET_NAME} SHARED
    ${SRC_DIR}/imgui.cpp
    ${SRC_DIR}/imgui_widgets.cpp
    ${SRC_DIR}/imgui_tables.cpp
    ${SRC_DIR}/imgui_draw.cpp
    ${SRC_DIR}/imgui_demo.cpp
    ${SRC_DIR}/backends/imgui_impl_win32.cpp
    ${SRC_DIR}/backends/imgui_impl_glfw.cpp
    ${SRC_DIR}/backends/imgui_impl_opengl3.cpp
    ${GLFW_DIR}/deps/glad_gl.c
)
TARGET_INCLUDE_DIRECTORIES(${TARGET_NAME} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
    ${SRC_DIR}
    ${GLFW_DIR}/include
    ${GLFW_DIR}/deps
)
TARGET_COMPILE_DEFINITIONS(${TARGET_NAME} PRIVATE
    "IMGUI_API=__declspec( dllexport )"
)
TARGET_LINK_DIRECTORIES(${TARGET_NAME} PRIVATE
    "$<$<CONFIG:Release>:${GLFW_DIR}/build/src/Release>"
    "$<$<CONFIG:Debug>:${GLFW_DIR}/build/src/Debug>"
)
TARGET_LINK_LIBRARIES(${TARGET_NAME} PUBLIC
    glfw3
)
