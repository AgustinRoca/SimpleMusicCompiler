all: compile
	
compile:
	bison -d example.y
	flex example.l
	gcc -o compiler lex.yy.c example.tab.c -ly

debug:
	bison -d example.y --debug --verbose
	flex -d example.l
	gcc -o compiler lex.yy.c example.tab.c -ly