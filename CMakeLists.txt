cmake_minimum_required(VERSION 3.0)

project(logicCalculator)

find_package(BISON REQUIRED)

BISON_TARGET(LC src/logic_calc.y ${CMAKE_CURRENT_BINARY_DIR}/lc.c)

add_executable(logicCalculator ${BISON_LC_OUTPUTS})

install (TARGETS logicCalculator DESTINATION bin)



########################################## MANUALS ###########################

FIND_PROGRAM(GZIP_TOOL
             NAMES gzip
             PATHS /bin
                   /usr/bin
                   /usr/local/bin)

IF(NOT GZIP_TOOL)
  MESSAGE(FATAL_ERROR "Unable to find 'gzip' program") 
ENDIF(NOT GZIP_TOOL)

# Compression of the manuals
ADD_CUSTOM_COMMAND(OUTPUT logicCalc.1.gz
                   COMMAND ${GZIP_TOOL} -c logicCalc.1 > logicCalc.1.gz
                   DEPENDS logicCalc.1
                   COMMENT "Building logicCalc.1.gz")
#force compression
add_custom_target(run ALL
    DEPENDS logicCalc.1.gz)

# Installation of the manuals
INSTALL(FILES logicCalc.1.gz
        DESTINATION "share/man/man1"
        PERMISSIONS OWNER_READ GROUP_READ WORLD_READ RENAME logicCalc.1.gz)
#################################################################################



INCLUDE(InstallRequiredSystemLibraries)
