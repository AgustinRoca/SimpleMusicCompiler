# Commands
CC = gcc
YACC = bison
LEX = flex

# Files
NAME = musicCompiler
FILE_Y = $(NAME).y
FILE_L = $(NAME).l
LEX_OUT_FILE = lex.yy
YACC_OUT_FILE = $(NAME).tab
OUTPUT = compiler
OUTPUT_FILES_C = $(LEX_OUT_FILE).c $(YACC_OUT_FILE).c
OUTPUT_FILES_H = $(YACC_OUT_FILE).h
OUTPUT_FILES_O = $(OUTPUT_FILES_C:.c=.o)
OUTPUT_FILES = $(OUTPUT_FILES_C) $(OUTPUT_FILES_H) $(OUTPUT_FILES_O) $(OUTPUT)

# Flags
YACC_FLAGS = -d
LEX_FLAGS =
YACC_DEBUG = --verbose --debug
LEX_DEBUG = -d
CC_FLAGS = -ly


all: $(OUTPUT)
	
$(OUTPUT): $(OUTPUT_FILES_O)
	$(CC) $(CC_FLAGS) -o $(OUTPUT) $(OUTPUT_FILES_O)

$(YACC_OUT_FILE).o: $(YACC_OUT_FILE).c
	$(CC) -c $(YACC_OUT_FILE).c

$(LEX_OUT_FILE).o: $(LEX_OUT_FILE).c
	$(CC) -c $(LEX_OUT_FILE).c

$(LEX_OUT_FILE).c: $(YACC_OUT_FILE).h
	$(LEX) $(LEX_FLAGS) $(FILE_L)

$(YACC_OUT_FILE).h: $(YACC_OUT_FILE).c

$(YACC_OUT_FILE).c:
	$(YACC) $(YACC_FLAGS) $(FILE_Y)

debug:
	$(YACC) $(YACC_FLAGS) $(YACC_DEBUG) $(FILE_Y)
	$(LEX) $(LEX_FLAGS) $(LEX_DEBUG) $(FILE_L)
	$(CC) $(CC_FLAGS) -o $(OUTPUT) $(LEX_OUT_FILE).c $(YACC_OUT_FILE).c

clean:
	rm -f $(OUTPUT_FILES)