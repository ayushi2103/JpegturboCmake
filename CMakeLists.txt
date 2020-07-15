cmake_minimum_required(VERSION 3.16.2)
project(JPEGTurboSwift
  LANGUAGES Swift C)

include(ExternalProject)

# place all modules into `swift` in the root of the build tree
set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# enable shared libraries by default (Windows, Darwin)
#
# Windows does not yet support static libraries in Swift, Darwin no longer
# supports static libraries after ABI stability.
if(CMAKE_SYSTEM_NAME STREQUAL Windows OR CMAKE_SYSTEM_NAME STREQUAL Darwin)
  option(BUILD_SHARED_LIBS "Build shared libraries by default" YES)
endif()

ExternalProject_Add(libjpeg-turbo
  GIT_REPOSITORY
    git://github.com/libjpeg-turbo/libjpeg-turbo
  GIT_TAG
    master
  UPDATE_DISCONNECTED
    TRUE
  CMAKE_ARGS
    -D CMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM}
    -D ENABLE_SHARED=NO
  INSTALL_COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/Sources/libjpeg-turbo/module.modulemap <SOURCE_DIR>
  BUILD_BYPRODUCTS
    <BINARY_DIR>/${CMAKE_STATIC_LIBRARY_PREFIX}turbojpeg${CMAKE_STATIC_LIBRARY_SUFFIX}
  STEP_TARGETS
    build)
ExternalProject_Get_Property(libjpeg-turbo BINARY_DIR)
ExternalProject_Get_Property(libjpeg-turbo SOURCE_DIR)

add_library(turbojpeg STATIC IMPORTED)
set_target_properties(turbojpeg PROPERTIES
  IMPORTED_LOCATION ${BINARY_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}turbojpeg${CMAKE_STATIC_LIBRARY_SUFFIX}
  IMPORTED_INCLUDE_DIRECTORIES "${BINARY_DIR};${SOURCE_DIR}")
add_dependencies(turbojpeg libjpeg-turbo-build)

add_subdirectory(Sources)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
