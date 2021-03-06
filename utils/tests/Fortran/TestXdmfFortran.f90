!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!!     AUTHOR: Andrew Burns (andrew.j.burns2@us.army.mil)
!!
!!     Read the first hexahedron from the file generated by the
!!     OutputTestXdmfFortran program, then print the results for comparison.
!!     
!!     Link against the XdmfUtils library to compile.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

PROGRAM XdmfFortranExample
  
  IMPLICIT NONE
  INCLUDE 'Xdmf.f'

  INTEGER*8 obj
  character*256 infilename, itemName, itemKey, itemValue, itemTag
  REAL*4 myPointsOutput(36)
  INTEGER myConnectionsOutput(16)
  INTEGER myMappedNodes(3), myDimensions(3)
  REAL*8 myCellAttributeOutput(4), myNodeAttributeOutput(12), mySetOutput(12), myTestTime, myBrick(3), myOrigin(3)
  INTEGER numContained, typeHolder

  
  infilename = 'my_output.xmf'//CHAR(0)
  
  CALL XDMFINIT(obj)
  CALL XDMFREAD(obj, infilename)

  PRINT *, 'Load From: ', TRIM(infilename)
  PRINT *, 'Domain Properties'
  CALL XDMFRETRIEVEDOMAINNUMPROPERTIES(obj, numContained)
  PRINT *, 'number of Properties: ', numContained
  CALL XDMFRETRIEVEDOMAINTAG(obj, itemTag, 256)
  PRINT *, 'Domain Tag: ', itemTag
  CALL XDMFRETRIEVENUMDOMAINGRIDCOLLECTIONS(obj, numContained)
  PRINT *, 'Number of Grid Collections: ',   numContained
  CALL XDMFOPENDOMAINGRIDCOLLECTION(obj, 0, 1, 1, 1, 1)
  CALL XDMFRETRIEVENUMINFORMATION(obj, numContained)
  PRINT *, 'Number of Information for Grid: ', numContained
  PRINT *, 'Information 0'
  CALL XDMFRETRIEVEINFORMATIONNUMPROPERTIES(obj, 0, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVEINFORMATIONPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEINFORMATIONPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEINFORMATIONTAG(obj, 0, itemTag, 256)
  PRINT *, 'Information Tag: ', itemTag
  CALL XDMFRETRIEVEINFORMATION(obj, 0, itemKey, 256, itemValue, 256)
  PRINT *, 'Key: ', itemKey
  PRINT *, 'Value: ', itemValue
  CALL XDMFRETRIEVEINFORMATIONBYKEY(obj, itemKey, itemValue, 256)
  PRINT *, 'Value: ', itemValue
  CALL XDMFRETRIEVEGRIDCOLLECTIONNUMGRIDS(obj, XDMF_GRID_TYPE_UNSTRUCTURED,  numContained)
  PRINT *, 'Number of Grids contained in the Grid Collection: ', numContained
  CALL XDMFOPENGRIDCOLLECTIONGRID(obj, XDMF_GRID_TYPE_UNSTRUCTURED, 0, 1, 1, 1, 1)
  CALL XDMFRETRIEVEGRIDCOLLECTIONGRIDNAME(obj, XDMF_GRID_TYPE_UNSTRUCTURED, 0,  itemName, 256)
  PRINT *, "Grid Name: ", itemName
  CALL XDMFRETRIEVEGRIDCOLLECTIONGRIDTAG(obj, XDMF_GRID_TYPE_UNSTRUCTURED, 0, itemTag, 256)
  PRINT *, "Grid Tag: ", itemTag
  CALL XDMFRETRIEVEGRIDCOLLECTIONGRIDNUMPROPERTIES(obj, XDMF_GRID_TYPE_UNSTRUCTURED, 0, numContained)
  PRINT *, "Number of Properties: ", numContained
  PRINT *, "Grid Properties: "
  CALL XDMFRETRIEVEGRIDCOLLECTIONGRIDPROPERTY(obj, XDMF_GRID_TYPE_UNSTRUCTURED, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEGRIDCOLLECTIONGRIDPROPERTYBYKEY(obj, XDMF_GRID_TYPE_UNSTRUCTURED,  0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVETIME(obj, myTestTime)
  PRINT *, 'Grid Time: ', myTestTime
  CALL XDMFRETRIEVEGRIDCOLLECTIONTYPE(obj, typeHolder)
  PRINT *, 'Grid Collection Type: ', typeHolder
  CALL XDMFRETRIEVENUMATTRIBUTES(obj, numContained)
  PRINT *, 'Number of Grid Attributes: ', numContained
  PRINT *, 'Map'
  CALL XDMFRETRIEVEMAPNUMPROPERTIES(obj, 0, numContained)
  PRINT *, 'Number of Properties: ', numContained
  CALL XDMFRETRIEVEMAPPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEMAPPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEREMOTENODEIDS(obj, 0, 1, 3, myMappedNodes)
  PRINT *, 'Nodes: ', myMappedNodes
!!!! Unstructured and Curvilinear only
  PRINT *, 'Geometry'
  CALL XDMFRETRIEVEGEOMETRYNUMPROPERTIES(obj, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVEGEOMETRYPROPERTY(obj, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEGEOMETRYPROPERTYBYKEY(obj, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEGEOMETRYTAG(obj, itemTag, 256)
  PRINT *, 'Geometry Tag: ', itemTag
  CALL XDMFRETRIEVEGEOMETRYTYPE(obj, typeHolder)
  PRINT *, 'Geometry Type: ', typeHolder
  CALL XDMFRETRIEVEGEOMETRYVALUETYPE(obj, typeHolder)
  PRINT *, 'Geometry Value Type: ', typeHolder
  CALL XDMFRETRIEVEGEOMETRYSIZE(obj, numContained)
  PRINT *, 'Number of Values: ', numContained
  CALL XDMFRETRIEVEGEOMETRYNUMPOINTS(obj, numContained)
  PRINT *, 'Geometry Number of Points: ', numContained
  CALL XDMFRETRIEVEGEOMETRYVALUES(obj, myPointsOutput, XDMF_ARRAY_TYPE_FLOAT32, 36, 0, 1, 1)
  PRINT 1,  myPointsOutput
1 FORMAT (' ', 3F5.1, '\n ', 3F5.1, '\n ', 3F5.1, '\n')
!!!! / Unstructured and Curvilinear Grid only
!!!! Unstructured Grid only
  PRINT *, 'Topology'
  CALL XDMFRETRIEVETOPOLOGYNUMPROPERTIES(obj, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVETOPOLOGYPROPERTY(obj, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVETOPOLOGYPROPERTYBYKEY(obj, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVETOPOLOGYTAG(obj, itemTag, 256)
  PRINT *, 'Topology Tag: ', itemTag
  CALL XDMFRETRIEVETOPOLOGYTYPE(obj, typeHolder)
  PRINT *, 'Topology Type: ', typeHolder
  CALL XDMFRETRIEVETOPOLOGYVALUETYPE(obj, typeHolder)
  PRINT *, 'Topology Value Type: ', typeHolder
  CALL XDMFRETRIEVETOPOLOGYSIZE(obj, numContained)
  PRINT *, 'Number of Values: ', numContained
  CALL XDMFRETRIEVETOPOLOGYNUMELEMENTS(obj, numContained)
  PRINT *, 'Topology Number of elements: ', numContained
  CALL XDMFRETRIEVETOPOLOGYVALUES(obj, myConnectionsOutput, XDMF_ARRAY_TYPE_INT32, 16, 0, 1, 1)
  PRINT 2, myConnectionsOutput
2 FORMAT (' ', 8I3)
!!!! /Unstructured Grid Only
!!!! Curvilinear and Regular only
!!  PRINT *, 'Dimensions'
!!  CALL XDMFRETRIEVEDIMENSIONSNUMPROPERTIES(obj, numContained)
!!  PRINT *, 'Number of Properties: ', numContained
!!  CALL XDMFRETRIEVEDIMENSIONSPROPERTY(obj, 0, itemKey, 256, itemValue, 256)
!!  PRINT *, "Key: ", itemKey
!!  PRINT *, "Value: ", itemValue
!!  CALL XDMFRETRIEVEDIMENSIONSPROPERTYBYKEY(obj, itemKey, itemValue, 256)
!!  PRINT *, "Value: ", itemValue
!!  CALL XDMFRETRIEVEDIMENSIONSTAG(obj, itemTag, 256)
!!  PRINT *, "Dimension Tag: ", itemTag
!!  CALL XDMFRETRIEVEDIMENSIONSVALUETYPE(obj, typeHolder)
!!  PRINT *, "Dimension Value Type: ", typeHolder
!!  CALL XDMFRETRIEVEDIMENSIONSSIZE(obj, numContained)
!!  PRINT *, "Number of Values: ", numContained
!!  CALL XDMFRETRIEVEDIMENSIONSVALUES(obj, myDimensions, XDMF_ARRAY_TYPE_INT32, 3, 0, 1, 1)
!!  PRINT *, myDimensions
!!!! /Curvilinear and Regular only
!!!! Rectilinear Only
!!  PRINT *, 'Coordinates'
!!  CALL XDMFRETRIEVENUMCOORDINATES(obj, numContained)
!!  PRINT *, 'Number of Coordinates: ', numContained
!!  CALL XDMFRETRIEVECOORDINATEVALUETYPE(obj, 0, typeHolder)
!!  PRINT *, 'Coordinate Value Type', typeHolder
!!  CALL XDMFRETRIEVECOORDINATENUMPROPERTIES(obj, 0, numContained)
!!  PRINT *, 'Number of Properties', numContained
!!  CALL XDMFRETRIEVECOORDINATEPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
!!  PRINT *, 'Key: ', itemKey
!!  PRINT *, 'Value: ', itemValue
!!  CALL XDMFRETRIEVECOORDINATEPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
!!  PRINT *, 'Value: ', itemValue
!!  CALL XDMFRETRIEVECOORDINATESIZE(obj, 0, numContained)
!!  PRINT *, 'Size of Coordinate 0', numContained
!!  CALL XDMFRETRIEVECOORDINATESIZE(obj, 1, numContained)
!!  PRINT *, 'Size of Coordinate 1', numContained
!!  CALL XDMFRETRIEVECOORDINATESIZE(obj, 2, numContained)
!!  PRINT *, 'Size of Coordinate 2', numContained
!!  CALL XDMFRETRIEVECOORDINATEVALUES(obj, 0, myPointsOutput(1), XDMF_ARRAY_TYPE_FLOAT32, 12, 0, 1, 1)
!!  CALL XDMFRETRIEVECOORDINATEVALUES(obj, 0, myPointsOutput(13), XDMF_ARRAY_TYPE_FLOAT32, 12, 0, 1, 1)
!!  CALL XDMFRETRIEVECOORDINATEVALUES(obj, 0, myPointsOutput(25), XDMF_ARRAY_TYPE_FLOAT32, 12, 0, 1, 1)
!!  PRINT 1, myPointsOutput
!!!! /Rectilinear Only
!!!! Regular Grid Only
!! Brick and Origin
!!  PRINT *, 'Brick'
!!  CALL XDMFRETRIEVEBRICKNUMPROPERTIES(obj, numContained)
!!  PRINT *, 'Number of Properties: ', numContained
!!  CALL XDMFRETRIEVEBRICKPROPERTY(obj, 0, itemKey, 256, itemValue, 256)
!!  PRINT *, "Key: ", itemKey
!!  PRINT *, "Value: ", itemValue
!!  CALL XDMFRETRIEVEBRICKPROPERTYBYKEY(obj, itemKey, itemValue, 256)
!!  PRINT *, "Value: ", itemValue
!!  CALL XDMFRETRIEVEBRICKTAG(obj, itemTag, 256)
!!  PRINT *, "Brick Tag: ", itemTag
!!  CALL XDMFRETRIEVEBRICKVALUETYPE(obj, typeHolder)
!!  PRINT *, "Brick Value Type: ", typeHolder
!!  CALL XDMFRETRIEVEBRICKSIZE(obj, numContained)
!!  PRINT *, "Number of Values: ", numContained
!!  CALL XDMFRETRIEVEBRICKVALUES(obj, myBrick, XDMF_ARRAY_TYPE_FLOAT64, 3, 0, 1, 1)
!!  PRINT *, myBrick
!!  PRINT *, 'Origin'
!!  CALL XDMFRETRIEVEORIGINNUMPROPERTIES(obj, numContained)
!!  PRINT *, 'Number of Properties: ', numContained
!!  CALL XDMFRETRIEVEORIGINPROPERTY(obj, 0, itemKey, 256, itemValue, 256)
!!  PRINT *, "Key: ", itemKey
!!  PRINT *, "Value: ", itemValue
!!  CALL XDMFRETRIEVEORIGINPROPERTYBYKEY(obj, itemKey, itemValue, 256)
!!  PRINT *, "Value: ", itemValue
!!  CALL XDMFRETRIEVEORIGINTAG(obj, itemTag, 256)
!!  PRINT *, "Origin Tag: ", itemTag
!!  CALL XDMFRETRIEVEORIGINVALUETYPE(obj, typeHolder)
!!  PRINT *, "Origin Value Type: ", typeHolder
!!  CALL XDMFRETRIEVEORIGINSIZE(obj, numContained)
!!  PRINT *, "Number of Values: ", numContained
!!  CALL XDMFRETRIEVEORIGINVALUES(obj, myOrigin, XDMF_ARRAY_TYPE_FLOAT64, 3, 0, 1, 1)
!!  PRINT *, myOrigin
!!!! /Regular Grid Only
  CALL XDMFRETRIEVENUMSETS(obj, numContained)
  PRINT *, '\nNumber of Sets:', numContained
  PRINT *, '\nSet 0'
  CALL XDMFRETRIEVESETNUMPROPERTIES(obj, 0, numContained)
  PRINT *, 'Number of Properties: ', numContained
  CALL XDMFRETRIEVESETPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVESETPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVESETTYPE(obj, 0, typeHolder)
  PRINT *, 'Set Type: ', typeHolder
  CALL XDMFRETRIEVESETVALUETYPE(obj, 0, typeHolder)
  PRINT *, 'Set Value Type: ', typeHolder
  CALL XDMFRETRIEVESETNAME(obj, 0, itemName, 256)
  PRINT *, 'Set Name: ', itemName
  CALL XDMFRETRIEVESETTAG(obj, 0, itemTag, 256)
  PRINT *, 'Set Tag: ', itemTag
  CALL XDMFRETRIEVESETVALUES(obj, 0, mySetOutput, XDMF_ARRAY_TYPE_FLOAT64, 12, 0, 1, 1)
  PRINT 3, mySetOutput
  PRINT *, '\nAttribute 0'
  CALL XDMFRETRIEVEATTRIBUTENAME(obj, 0, itemName, 256)
  PRINT *, 'Attribute Name: ', itemName
  CALL XDMFRETRIEVEATTRIBUTENUMPROPERTIES(obj, 0, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVEATTRIBUTEPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEATTRIBUTEPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEATTRIBUTETAG(obj, 0, itemTag, 256)
  PRINT *, 'Attribute Tag: ', itemTag
  CALL XDMFRETRIEVEATTRIBUTETYPE(obj, 0, typeHolder)
  PRINT *, 'Attribute Type: ', typeHolder
  CALL XDMFRETRIEVEATTRIBUTECENTER(obj, 0, typeHolder)
  PRINT *, 'Attribute Center: ', typeHolder
  CALL XDMFRETRIEVEATTRIBUTEVALUETYPE(obj, 0, typeHolder)
  PRINT *, 'Attribute Value Type: ', typeHolder
  CALL XDMFRETRIEVEATTRIBUTESIZE(obj, 0, numContained)
  PRINT *, 'Number of Values: ', numContained
  CALL XDMFRETRIEVEATTRIBUTEVALUES(obj, 0, myNodeAttributeOutput, XDMF_ARRAY_TYPE_FLOAT64, 12, 0, 1, 1)
  PRINT 3, myNodeAttributeOutput
3 FORMAT (' ', 3F6.1)
  CALL XDMFOPENATTRIBUTE(obj, 0)
  CALL XDMFRETRIEVENUMINFORMATION(obj, numContained)
  PRINT *, 'Number of Information for Grid and Attribute 0: ', numContained
  PRINT *, 'Information 0'
  CALL XDMFRETRIEVEINFORMATIONNUMPROPERTIES(obj, 0, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVEINFORMATIONPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEINFORMATIONPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEINFORMATIONTAG(obj, 0, itemTag, 256)
  PRINT *, 'Information Tag: ', itemTag
  CALL XDMFRETRIEVEINFORMATION(obj, 1, itemKey, 256, itemValue, 256)
  PRINT *, 'Key: ', itemKey
  PRINT *, 'Value: ', itemValue
  CALL XDMFRETRIEVEINFORMATIONBYKEY(obj, itemKey, itemValue, 256)
  PRINT *, 'Value: ', itemValue
  PRINT *, '\nAttribute 1'
  CALL XDMFRETRIEVEATTRIBUTENUMPROPERTIES(obj, 1, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVEATTRIBUTEPROPERTY(obj, 1, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEATTRIBUTEPROPERTYBYKEY(obj, 1, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEATTRIBUTENAME(obj, 1, itemName, 256)
  PRINT *, 'Attribute Name: ', itemName
  CALL XDMFRETRIEVEATTRIBUTETAG(obj, 1, itemTag, 256)
  PRINT *, 'Attribute Tag: ', itemTag
  CALL XDMFRETRIEVEATTRIBUTETYPE(obj, 1, typeHolder)
  PRINT *, 'Attribute Type: ', typeHolder
  CALL XDMFRETRIEVEATTRIBUTECENTER(obj, 1, typeHolder)
  PRINT *, 'Attribute Center: ', typeHolder
  CALL XDMFRETRIEVEATTRIBUTEVALUETYPE(obj, 1, typeHolder)
  PRINT *, 'Attribute Value Type: ', typeHolder
  CALL XDMFRETRIEVEATTRIBUTESIZE(obj, 1, numContained)
  PRINT *, 'Number of Values: ', numContained
  CALL XDMFRETRIEVEATTRIBUTEVALUES(obj, 1, myCellAttributeOutput, XDMF_ARRAY_TYPE_FLOAT64, 4, 0, 1, 1)
  PRINT 4, myCellAttributeOutput
4 FORMAT (' ', F6.1)
  CALL XDMFOPENATTRIBUTE(obj, 1)
  CALL XDMFRETRIEVENUMINFORMATION(obj, numContained)
  PRINT *, 'Number of Information for Grid and Attribute 0: ', numContained
  PRINT *, 'Information 0'
  CALL XDMFRETRIEVEINFORMATIONNUMPROPERTIES(obj, 0, numContained)
  PRINT *, "Number of Properties: ", numContained
  CALL XDMFRETRIEVEINFORMATIONPROPERTY(obj, 0, 0, itemKey, 256, itemValue, 256)
  PRINT *, "Key: ", itemKey
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEINFORMATIONPROPERTYBYKEY(obj, 0, itemKey, itemValue, 256)
  PRINT *, "Value: ", itemValue
  CALL XDMFRETRIEVEINFORMATIONTAG(obj, 0, itemTag, 256)
  PRINT *, 'Information Tag: ', itemTag
  CALL XDMFRETRIEVEINFORMATION(obj, 0, itemKey, 256, itemValue, 256)
  PRINT *, 'Key: ', itemKey
  PRINT *, 'Value: ', itemValue
  CALL XDMFRETRIEVEINFORMATIONBYKEY(obj, itemKey, itemValue, 256)
  PRINT *, 'Key: ', itemKey
  PRINT *, 'Value: ', itemValue


  CALL XDMFCLOSE(obj)

END PROGRAM XdmfFortranExample
