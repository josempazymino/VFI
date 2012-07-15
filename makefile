CPUCC    = g++
GPUCC    = nvcc --ptxas-options=-v
SDIR     = .
ICUDA    = /usr/local/cuda/include
LCUDA    = /usr/local/cuda/lib
CPUFLAGS = -O2 -c -I$(SDIR)
GPUFLAGS = -O2 -m64 -c -I$(SDIR) -I$(ICUDA) --gpu-architecture sm_11
LFLAGS   = -L$(LCUDA) -lcublas -lm -lgslcblas
HEADERS  = $(SDIR)/auxfuncs.h $(SDIR)/globalvars.h
OBJECTS  = vfiGPU.o vfiCPU.o ar1.o kGrid.o vfInit.o binary_val.o ncdf.o vfStep.o grid_max.o binary_max.o globalvars.o

vfi : 		vfi.o $(OBJECTS) $(HEADERS)
		$(GPUCC) -m64 -o vfi vfi.o $(OBJECTS) $(LFLAGS) 

vfi.o : 	$(SDIR)/vfi.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/vfi.cpp

vfiGPU.o : 	$(SDIR)/vfiGPU.cu $(HEADERS)
		$(GPUCC) $(GPUFLAGS) $(SDIR)/vfiGPU.cu

vfiCPU.o : 	$(SDIR)/vfiCPU.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/vfiCPU.cpp

ar1.o : 	$(SDIR)/ar1.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/ar1.cpp

kGrid.o : 	$(SDIR)/kGrid.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/kGrid.cpp

vfInit.o : 	$(SDIR)/vfInit.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/vfInit.cpp

binary_val.o : 	$(SDIR)/binary_val.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/binary_val.cpp

ncdf.o : 	$(SDIR)/ncdf.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/ncdf.cpp

vfStep.o : 	$(SDIR)/vfStep.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/vfStep.cpp

grid_max.o : 	$(SDIR)/grid_max.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/grid_max.cpp

binary_max.o : 	$(SDIR)/binary_max.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/binary_max.cpp

globalvars.o : 	$(SDIR)/globalvars.cpp  $(HEADERS)
		$(CPUCC) $(CPUFLAGS) $(SDIR)/globalvars.cpp

clean :
	rm -f *.o
	rm -f core core.*

veryclean :
	rm -f *.o
	rm -f core core.*
	rm -f *.linkinfo
	rm -f vfi
