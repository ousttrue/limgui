set(TARGET_NAME glad)
set(GLFW_DIR ${CMAKE_CURRENT_LIST_DIR}/../glfw/glfw)
add_library(${TARGET_NAME} SHARED ${GLFW_DIR}/deps/glad_gl.c)
target_include_directories(${TARGET_NAME} PUBLIC ${GLFW_DIR}/deps)
target_compile_definitions(
  ${TARGET_NAME}
  PUBLIC "GLAD_API_CALL_EXPORT=1"
  PRIVATE "GLAD_API_CALL_EXPORT_BUILD")
target_link_directories(
  ${TARGET_NAME} PRIVATE "$<$<CONFIG:Release>:${GLFW_DIR}/build/src/Release>"
  "$<$<CONFIG:Debug>:${GLFW_DIR}/build/src/Debug>")
