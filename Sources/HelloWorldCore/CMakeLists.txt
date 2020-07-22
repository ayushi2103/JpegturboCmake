
add_library(HelloWorldCore 
  SHARED
  HelloWorldCore.swift)




set_target_properties(HelloWorldCore PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

target_include_directories(HelloWorldCore PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${SOURCE_DIR}
   ${BINARY_DIR})
   
target_link_libraries(HelloWorldCore 
turbojpeg)



install(TARGETS HelloWorldCore
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  )