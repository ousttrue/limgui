set(TARGET_NAME mikktspace)
add_library(${TARGET_NAME} SHARED)
target_sources(${TARGET_NAME} PRIVATE
mikktspace.c
mikktspace.def
)