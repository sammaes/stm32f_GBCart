# Directories
BINDIR=bin
SRCDIR=src
BUILDDIR=build
TOOLSDIR=tools
INCLUDEDIR=include

# Put your stlink folder here so make burn will work.
STLINK=~/stlink/build/Release

SRCS=$(SRCDIR)/main.c $(SRCDIR)/system_stm32f4xx.c $(SRCDIR)/stm32f4xx_it.c $(SRCDIR)/init_gpio.c

# Library modules
SRCS += stm32f4xx_exti.c stm32f4xx_gpio.c stm32f4xx_rcc.c stm32f4xx_syscfg.c
SRCS += stm32f4xx_tim.c misc.c
SRCS += stm32f4_discovery.c

# Binaries will be generated with this name (.elf, .bin, .hex, etc)
PROJ_NAME=gbcart

#######################################################################################

STM_COMMON=/home/sam/bin/ProgramFiles/stm32_discovery_arm_gcc/STM32F4-Discovery_FW_V1.1.0

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

CFLAGS  = -g -O2 -Wall -T$(TOOLSDIR)/stm32_flash.ld
CFLAGS += -DUSE_STDPERIPH_DRIVER
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += -I$(INCLUDEDIR)

# Include files from STM libraries
CFLAGS += -I$(STM_COMMON)/Utilities/STM32F4-Discovery
CFLAGS += -I$(STM_COMMON)/Libraries/CMSIS/Include 
CFLAGS += -I$(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Include
CFLAGS += -I$(STM_COMMON)/Libraries/STM32F4xx_StdPeriph_Driver/inc


# add startup file to build
SRCS += $(STM_COMMON)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f4xx.s 

OBJS = $(SRCS:.c=.o)

vpath %.c $(STM_COMMON)/Libraries/STM32F4xx_StdPeriph_Driver/src $(STM_COMMON)/Utilities/STM32F4-Discovery

.PHONY: proj

all: proj

proj: $(PROJ_NAME).elf

$(PROJ_NAME).elf: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@
	mv $(PROJ_NAME).elf $(BINDIR)/$(PROJ_NAME).elf
	$(OBJCOPY) -O ihex $(BINDIR)/$(PROJ_NAME).elf $(BINDIR)/$(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(BINDIR)/$(PROJ_NAME).elf $(BINDIR)/$(PROJ_NAME).bin
	mv $(SRCDIR)/*.o $(BUILDDIR)/
	mv *.o $(BUILDDIR)/

clean:
	rm -f $(BUILDDIR)/*.o
	rm -f $(BINDIR)/$(PROJ_NAME).elf
	rm -f $(BINDIR)/$(PROJ_NAME).hex
	rm -f $(BINDIR)/$(PROJ_NAME).bin


# Flash the STM32F4
burn: proj
	$(STLINK)/st-flash write $(BINDIR)/$(PROJ_NAME).bin 0x8000000
