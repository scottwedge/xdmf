from Xdmf import *

import timeit
import time

if __name__ == "__main__":

	#for later use in determining actual time
	#    print timeit.Timer(timedWrite.write).timeit(1)

        exampleHeavyWriter = XdmfHDF5Writer.New("timestamptest.h5")

        #possible options
        exampleHeavyWriter.setReleaseData(True)

        exampleWriter = XdmfWriter.New("timestamptest.xmf", exampleHeavyWriter)
        exampleWriter.setLightDataLimit(10)


	primaryDomain = XdmfDomain.New()

	numNodes = 30000
	numAttrib = 10
	gridsPerTimestamp = 10
	numTimestamps = 100

	#for 100 time steps
	#each time step is a grid collection
	#base structue is a spacial grid collection full of temporal grid collections

	primaryCollection = XdmfGridCollection.New()

	primaryDomain.insert(primaryCollection)

	startclock = time.clock()

	for i in range(numTimestamps):
		#print "timestamp " + str(i)
		timestampGrid = XdmfGridCollection.New()
		timestampTime = XdmfTime.New(i)
		timestampGrid.setTime(timestampTime)
		#each time stamp has 10 grids
		for j in range(gridsPerTimestamp):
			sectionGrid = XdmfUnstructuredGrid.New()
			sectionTime = XdmfTime.New(i)
			sectionGrid.setTime(sectionTime)
			#each grid has one topo, one geo, and 10 attrib
			sectionGeometry = XdmfGeometry.New()
			sectionGeometry.setType(XdmfGeometryType.XYZ())
			sectionTopology = XdmfTopology.New()
			sectionTopology.setType(XdmfTopologyType.Triangle())
			#Fill each with 30,000 values
			#for k in range(numNodes):
			#	sectionGeometry.pushBackAsFloat32(k)
			#	sectionTopology.pushBackAsFloat32(k)
			sectionGeometry.resizeAsFloat32(30000)
			sectionTopology.resizeAsFloat32(30000)
			sectionGrid.setGeometry(sectionGeometry)
			sectionGrid.setTopology(sectionTopology)
			for k in range(numAttrib):
				sectionAttribute = XdmfAttribute.New()
				#for l in range(numNodes):
				#	sectionAttribute.pushBackAsFloat32(l)
				sectionAttribute.resizeAsFloat32(30000)
				sectionGrid.insert(sectionAttribute)
			timestampGrid.insert(sectionGrid)
			#exampleHeavyWriter.openFile()
			#sectionGrid.accept(exampleHeavyWriter)
			#exampleHeavyWriter.closeFile()
		primaryCollection.insert(timestampGrid)
		exampleHeavyWriter.openFile()
		timestampGrid.accept(exampleHeavyWriter)
		#primaryDomain.accept(exampleHeavyWriter)
		#primaryDomain.accept(exampleWriter)
		exampleHeavyWriter.closeFile()


	exampleHeavyWriter.openFile()
	primaryDomain.accept(exampleWriter)

	exampleHeavyWriter.closeFile()

	print (time.clock() - startclock)
