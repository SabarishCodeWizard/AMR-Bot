# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appsampleAmr_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appsampleAmr_autogen.dir/ParseCache.txt"
  "appsampleAmr_autogen"
  )
endif()
