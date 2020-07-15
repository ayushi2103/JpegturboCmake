
add_library(ImageOps SHARED
  ImageOps.c)



target_include_directories(ImageOps PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${SOURCE_DIR}
   ${BINARY_DIR})

target_link_libraries(ImageOps PUBLIC
  turbojpeg)

install(TARGETS ImageOps
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

