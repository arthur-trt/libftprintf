#Compiler and Linker
CC				:= clang-9
ifeq ($(shell uname -s),Darwin)
	CC			:= gcc
endif

#The Target Binary Program
TARGET			:= libftprintf.a

BUILD			:= release

include sources.mk

#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR			:= srcs
INCDIR			:= includes
BUILDDIR		:= obj
TARGETDIR		:= .
SRCEXT			:= c
DEPEXT			:= d
OBJEXT			:= o

OBJECTS			:= $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT)))

#Flags, Libraries and Includes
cflags.release		:= -Wall -Werror -Wextra
cflags.valgrind		:= -Wall -Werror -Wextra -DDEBUG -ggdb
cflags.debug		:= -Wall -Werror -Wextra -DDEBUG -ggdb -fsanitize=address -fno-omit-frame-pointer
CFLAGS			:= $(cflags.$(BUILD))

lib.release		:=

lib.debug		:= $(lib.release) -fsanitize=address -fno-omit-frame-pointer
LIB			:= $(lib.$(BUILD))

INC			:= -I$(INCDIR) -I/usr/local/include
INCDEP			:= -I$(INCDIR)

# Colors
C_RESET			:= \033[0m
C_PENDING		:= \033[0;36m
C_SUCCESS		:= \033[0;32m

# Multi platforms
ECHO			:= echo

# Escape sequences (ANSI/VT100)
ES_ERASE		:= "\033[1A\033[2K\033[1A"
ERASE			:= $(ECHO) $(ES_ERASE)

# hide STD/ERR and prevent Make from returning non-zero code
HIDE_STD		:= > /dev/null
HIDE_ERR		:= 2> /dev/null || true

GREP			:= grep --color=auto --exclude-dir=.git
NORMINETTE		:= norminette `ls`

#Defauilt Make
all: directories $(TARGET)
	@$(ERASE)
	@$(ECHO) "$(TARGET)\t\t[$(C_SUCCESS)✅$(C_RESET)]"
	@$(ECHO) "$(C_SUCCESS)All done, compilation successful! 👌 $(C_RESET)"

#Remake
re: fclean all

#Make the Directories
directories:
	@mkdir -p $(TARGETDIR)
	@mkdir -p $(BUILDDIR)

#Clean only Objecst
clean:
	@$(RM) -rf $(BUILDDIR)


#Full Clean, Objects and Binaries
fclean: clean
	@$(RM) -rf $(TARGET)


#Pull in dependency info for *existing* .o files
-include $(OBJECTS:.$(OBJEXT)=.$(DEPEXT))

#Link
$(TARGET): $(OBJECTS)
	@ar rcs $(TARGET) $(OBJECTS)
	@ranlib $(TARGET)

#Compile
$(BUILDDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@)
	@$(ECHO) "$(TARGET)\t\t[$(C_PENDING)⏳$(C_RESET)]"
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<
	@$(CC) $(CFLAGS) $(INCDEP) -MM $(SRCDIR)/$*.$(SRCEXT) > $(BUILDDIR)/$*.$(DEPEXT)
	@$(ERASE)
	@$(ERASE)
	@cp -f $(BUILDDIR)/$*.$(DEPEXT) $(BUILDDIR)/$*.$(DEPEXT).tmp
	@sed -e 's|.*:|$(BUILDDIR)/$*.$(OBJEXT):|' < $(BUILDDIR)/$*.$(DEPEXT).tmp > $(BUILDDIR)/$*.$(DEPEXT)
	@sed -e 's/.*://' -e 's/\\$$//' < $(BUILDDIR)/$*.$(DEPEXT).tmp | fmt -1 | sed -e 's/^ *//' -e 's/$$/:/' >> $(BUILDDIR)/$*.$(DEPEXT)
	@rm -f $(BUILDDIR)/$*.$(DEPEXT).tmp



norm:
	@$(NORMINETTE) | $(GREP) -v "Not a valid file" | $(GREP) "Error\|Warning" -B 1 || true

#Non-File Targets
.PHONY: all re clean fclean norm
