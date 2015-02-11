SET(HEIDISQL_BASE_NAME "HeidiSQL_9.1_Portable")
SET(HEIDISQL_ZIP "${HEIDISQL_BASE_NAME}.zip")
SET(HEIDISQL_URL "http://www.heidisql.com/downloads/releases/${HEIDISQL_ZIP}")
SET(HEIDISQL_DOWNLOAD_DIR ${THIRD_PARTY_DOWNLOAD_LOCATION}/${HEIDISQL_BASE_NAME})

IF(NOT EXISTS ${HEIDISQL_DOWNLOAD_DIR}/${HEIDISQL_ZIP})
  MAKE_DIRECTORY(${HEIDISQL_DOWNLOAD_DIR}) 
  MESSAGE(STATUS "Downloading ${HEIDISQL_URL} to ${HEIDISQL_DOWNLOAD_DIR}/${HEIDISQL_ZIP}")
  FILE(DOWNLOAD ${HEIDISQL_URL} ${HEIDISQL_DOWNLOAD_DIR}/${HEIDISQL_ZIP} TIMEOUT 60)
  EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E chdir ${HEIDISQL_DOWNLOAD_DIR}
    ${CMAKE_COMMAND} -E tar xfz ${HEIDISQL_DOWNLOAD_DIR}/${HEIDISQL_ZIP}
  )
ENDIF()

SET(LIBMYSQLDLL_SOURCE ${HEIDISQL_DOWNLOAD_DIR}/libmysql.dll)
IF(CMAKE_SIZEOF_VOID_P EQUAL 4)
  # Use our libmysql if it is 32 bit.
  IF(LIBMYSQL_LOCATION)
    SET(LIBMYSQLDLL_SOURCE "${LIBMYSQL_LOCATION}")
  ENDIF()
ENDIF()
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/heidisql.wxi.in ${CMAKE_CURRENT_BINARY_DIR}/heidisql.wxi)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/heidisql_feature.wxi.in ${CMAKE_CURRENT_BINARY_DIR}/heidisql_feature.wxi)
