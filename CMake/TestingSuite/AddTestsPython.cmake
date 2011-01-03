INCLUDE(TestingSetup)

# Variables that are set externally
SET(python_binary_dir ${CMAKE_CURRENT_BINARY_DIR})
SET(python_source_dir ${CMAKE_CURRENT_SOURCE_DIR})

# Python Add Dependencies Macro
# Author: Brian Panneton
# Description: This macro adds the python test dependencies.
#        Note: The tests already depend on their own file
# Parameters:         
#              dependencies         = any dependencies needed for python tests
MACRO(ADD_TEST_PYTHON_DEPENDENCIES dependencies)
	IF(NOT ("${dependencies}" STREQUAL ""))
	        SET_PROPERTY(GLOBAL APPEND PROPERTY PYTHON_TEST_DEPENDENCIES 
        	        "${dependencies}"
	        )
	ENDIF(NOT ("${dependencies}" STREQUAL ""))
ENDMACRO(ADD_TEST_PYTHON_DEPENDENCIES dependencies)

# Python Add Dependencies Macro
# Author: Brian Panneton
# Description: This macro adds the python test dependencies.
#        Note: The tests already depend on their own file
# Parameters:         
#              dependencies         = any dependencies needed for python tests
MACRO(ADD_TEST_PYTHON_FILE_DEPENDENCIES dependencies)
	IF(NOT ("${dependencies}" STREQUAL ""))
	        SET_PROPERTY(GLOBAL APPEND PROPERTY PYTHON_TEST_FILE_DEPENDENCIES 
        	        "${dependencies}"
	        )
	ENDIF(NOT ("${dependencies}" STREQUAL ""))
ENDMACRO(ADD_TEST_PYTHON_FILE_DEPENDENCIES dependencies)

# Python Add PythonPath Macro
# Author: Brian Panneton
# Description: This macro adds the python test pythonpaths.
# Parameters:         
#              pyp         = any pythonpaths needed for python tests
MACRO(ADD_TEST_PYTHON_PYTHONPATH pyp)
        GET_PROPERTY(pythonpath GLOBAL PROPERTY PYTHON_TEST_PYTHONPATH)
        IF(NOT ("${pyp}" STREQUAL ""))
                SET_PROPERTY(GLOBAL PROPERTY PYTHON_TEST_PYTHONPATH 
                        "${pythonpath}${sep}${pyp}" 
                )
        ENDIF(NOT ("${pyp}" STREQUAL ""))
ENDMACRO(ADD_TEST_PYTHON_PYTHONPATH cp)


# Add Python Test Macro
# Author: Brian Panneton
# Description:	This macro compiles and adds the python test in one shot. There is
#		no need to build a test separately, because there isn't a case 
#		that you don't want to run it.
# Parameters: 
#		executable 	= executable name 
#		${ARGN}		= any arguments for the executable
#
MACRO(ADD_TEST_PYTHON executable)
	
	PARSE_TEST_ARGS("${ARGN}")

	GET_PROPERTY(python_file_dependencies GLOBAL 
			PROPERTY PYTHON_TEST_FILE_DEPENDENCIES)
	GET_PROPERTY(python_pythonpath GLOBAL PROPERTY PYTHON_TEST_PYTHONPATH)
	
	ADD_CUSTOM_COMMAND(
		OUTPUT ${python_binary_dir}/${executable}.pyc
		WORKING_DIRECTORY ${python_binary_dir} 
		COMMAND ${CMAKE_COMMAND}
		ARGS 	-E copy
			${python_source_dir}/${executable}.py
			${python_binary_dir}/${executable}.py
		COMMAND ${PYTHON_EXECUTABLE} 
		ARGS	-mpy_compile
			${python_binary_dir}/${executable}.py
		DEPENDS ${python_source_dir}/${executable}.py
			${python_file_dependencies}
	)
	
	SET_PROPERTY(GLOBAL APPEND PROPERTY PYTHON_TEST_TARGETS "${python_binary_dir}/${executable}.pyc")

	SET_CORE("${python_binary_dir}")
    ADD_TEST(Python${is_core}_${executable}${dup} ${CMAKE_COMMAND}
            -D "EXECUTABLE=${executable}"
            -D "ARGUMENTS=${arguments}"
            -D "PYTHONPATH=${python_pythonpath}"
            -D "SEPARATOR=${sep}"
            -P "${python_binary_dir}/TestDriverPython.cmake"
    )
ENDMACRO(ADD_TEST_PYTHON executable)

# Python Clean Macro
# Author: Brian Panneton
# Description: This macro sets up the python test for a make clean.
# Parameters:         
#              executable      = executable name
#              ${ARGN}         = files that the executable created
MACRO(CLEAN_TEST_PYTHON executable)
	set_property(DIRECTORY APPEND PROPERTY
		ADDITIONAL_MAKE_CLEAN_FILES ${ARGN}
		${executable}.py
	)
ENDMACRO(CLEAN_TEST_PYTHON executable)


# Python Create Target Macro
# Author: Brian Panneton
# Description: This macro sets up the python test target
# Parameters:	none
MACRO(CREATE_TARGET_TEST_PYTHON)
	IF(EXISTS PythonCore_ALLTEST)
        	SET(PythonCore_ALLTEST PythonCore_ALLTEST)
	ENDIF(EXISTS PythonCore_ALLTEST)

    GET_PROPERTY(python_dependencies GLOBAL PROPERTY PYTHON_TEST_DEPENDENCIES)	

	SET_CORE("${python_binary_dir}")
	GET_PROPERTY(targets GLOBAL PROPERTY PYTHON_TEST_TARGETS)
	ADD_CUSTOM_TARGET(Python${is_core}_ALLTEST ALL DEPENDS 
		${PythonCore_ALLTEST} ${targets})

    IF(NOT ("${python_dependencies}" STREQUAL ""))
        ADD_DEPENDENCIES(Python${is_core}_ALLTEST ${python_dependencies})
	ENDIF(NOT ("${python_dependencies}" STREQUAL ""))

	IF(NOT ("${is_core}" STREQUAL ""))
		SET_PROPERTY(GLOBAL PROPERTY PYTHON_TEST_TARGETS "")
	ENDIF(NOT ("${is_core}" STREQUAL ""))

ENDMACRO(CREATE_TARGET_TEST_PYTHON)


# Configure the python 'driver' file
CONFIGURE_FILE(${TESTING_SUITE_DIR}/TestingSuite/TestDriverPython.cmake.in ${python_binary_dir}/TestDriverPython.cmake @ONLY)

