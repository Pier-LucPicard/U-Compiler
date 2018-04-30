%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;

int yylex();
void yyerror(const char *s) {fprintf(stderr, "Erreur: (ligne %d) %s\n", yylineno, s); exit(1);}

%}

%union {
    char *string_lit;
    int int_lit;
}

%locations
%error-verbose

%token tDEFINIR tCOMEUNE tQUANTITY tAVECVALEUR tCOMME tUN tUNE tFIN tDEBUT

%token <string_lit>  tIDENTIFIER
%token <int_lit> tINTLITERAL 

%start program
%%


program: '+'
    | definition
    | ;

definition: tDEFINIR tIDENTIFIER tCOMME tUN tQUANTITY tAVECVALEUR  tINTLITERAL '.'

%%