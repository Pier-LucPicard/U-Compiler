#include <stdio.h>
#include <string.h>
void yyparse();
int yylex();

FILE* fd;


int main(int argc, char **argv) {

    fd=stdout;

 if(strcmp(argv[1],"tokens") == 0){
        int res = 1;

        while(res !=0){
            res =yylex();
        }
        return 0;
    }else if(strcmp(argv[1],"scan") == 0){
        fd = fopen ("/dev/null", "w");
        int res = 1;

        while(res !=0){
            res =yylex();
        }
        fd = stdout;
        printf( "OK\n");
        return 0;
    }else if(strcmp(argv[1],"parse") == 0){
        fd = fopen ("/dev/null", "w");
        yyparse();
        fd = stdout;
        printf( "OK\n");
        return 0;
    }else{
        fprintf(stdout, "Command not found\n");
    }
}
