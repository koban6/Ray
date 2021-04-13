include Makefile.config

DEBUG ?=
ifeq ($(DEBUG), 1)
        CXXFLAGS += -O0 -g -ggdb
        LDFLAGS  += -O0 -g -ggdb
else
        CXXFLAGS += -O3
        LDFLAGS  += -O3
endif

TARGET = ray
CXX = g++
CXXFLAGS += -std=c++11
WARNING = -Wall


SRC_ROOT = ./src
SRC_DIRS = $(shell find $(SRC_ROOT) -type d)

OBJ_DIR = ./obj
INCLUDE_DIR = ./include

SOURCES = $(shell find $(SRC_ROOT) -name '*.cpp')

OBJECTS = $(subst $(SRC_ROOT), $(OBJ_DIR), $(SOURCES))
OBJECTS := $(subst .cpp,.o,$(OBJECTS))

DEPENDS = $(OBJECTS:.o=.d)

INCLUDE += -I$(INCLUDE_DIR)
LDFLAGS += -lm -lpthread

$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LIB_CUDA) $(LIB_REDIS)

$(SRC_ROOT)/%.cpp: $(SRC_ROOT)/%.cu
	$(NVCC) $(NVCCFLAGS) $(INCLUDE) --cuda $< -o $@

$(OBJ_DIR)/%.o: $(SRC_ROOT)/%.cpp
	@if [ ! -e `dirname $@` ]; then mkdir -p `dirname $@`; fi
	$(CXX) $(WARNING) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

all: clean $(TARGET)

clean:
	-rm -f *~ $(TARGET) $(SRC_ROOT)/*~ $(SRC_ROOT)/*~ $(OBJ_DIR)/*~ $(INCLUDE_DIR)/*~ 

-include $(DEPENDS)


