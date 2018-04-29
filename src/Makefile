CC = gcc

CFLAGS = -Wall

main: parser.tab.o main.o codegen.h  memory.h memory.o type.h type.o symbol.h symbol.o tree.h  tree.o pretty.h  pretty.o  weed.h weed.o  codegen.o lex.yy.o 
	$(CC) lex.yy.o parser.tab.o  memory.o symbol.o type.o   tree.o codegen.o pretty.o main.o weed.o -o us -lfl

parser.tab.c parser.tab.h: u.y
	bison  --yacc --defines=parser.tab.c --output=parser.tab.h us.y -v

lex.yy.c: goLite.l parser.tab.h
	flex goLite.l
	
clean:
	rm parser.tab.* lex.yy.*; rm *.o
