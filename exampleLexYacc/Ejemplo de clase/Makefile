all:
	bison -d looping.y
	flex looping.l
	gcc -o looping lex.yy.c looping.tab.c -ly