############################################################################
# <summary> CMakeLists.txt for OpenCV and CUDA. </summary>
# <date>    2012-02-07          </date>
# <author>  Quan Tran Minh. edit by Johannes Kast, Michael Sarahan </author>
# <email>   quantm@unist.ac.kr  kast.jo@googlemail.com msarahan@gmail.com</email>
############################################################################


cmake_minimum_required(VERSION 3.11 FATAL_ERROR)
project(HW1 LANGUAGES CXX CUDA)



add_library(boo STATIC
  compare.cpp
  compare.h
  HW1.cpp
  main.cpp
  reference_calc.cpp
  reference_calc.h
  student_func.cu
  timer.h
  utils.h
    )


target_compile_features(boo PUBLIC cxx_std_11)

set_target_properties( boo
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON
)

add_executable(boo_test student_func.cu)

set_property(TARGET boo_test
             PROPERTY CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(boo_test PRIVATE boo)

# if(BUILD_TESTING)
#
#   add_executable(particle_test test.cu)
#
#   set_target_properties(particle_test PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
#   target_link_libraries(particle_test PRIVATE particles)
#
#   add_test(NAME particles_10k COMMAND particle_test 10000 )
#   add_test(NAME particles_256k COMMAND particle_test 256000 )
#
# endif()

# # collect source files
#
# file( GLOB  hdr *.hpp *.h )
# file( GLOB  cu  *.cu)
# SET (HW1_files main.cpp reference_calc.cpp compare.cpp)
#
# # CUDA_ADD_EXECUTABLE(HW1 ${HW1_files} ${hdr} ${cu})
# project(HW1 ${HW1_files} LANGUAGE C CXX CUDA)
