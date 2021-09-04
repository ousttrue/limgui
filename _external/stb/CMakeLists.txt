set(TARGET_NAME stb)
add_library(${TARGET_NAME} SHARED)
target_sources(${TARGET_NAME} PRIVATE main.cpp)
target_compile_definitions(${TARGET_NAME}
                           PRIVATE "STBIDEF=__declspec(dllexport)")
target_include_directories(${TARGET_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/stb)
