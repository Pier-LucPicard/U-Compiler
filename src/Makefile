CC = gcc

CFLAGS = -Wall

main: parser.tab.o main.o lex.yy.o 
	$(CC) lex.yy.o parser.tab.o main.o -o us -lfl

parser.tab.c parser.tab.h: us.y
	bison  --yacc --defines=parser.tab.c --output=parser.tab.h us.y -v

lex.yy.c: us.l parser.tab.h
	flex us.l
	
clean:
	rm parser.tab.* lex.yy.*; rm *.o
