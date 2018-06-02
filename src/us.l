%{
#include <stdio.h>
#include <string.h>

#include "parser.tab.h"
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;


extern FILE* fd;

void output(char * out){
    fprintf(fd, "%s\n",out);
}
%}

%option yylineno
%option noinput
%option nounput

%%
[ \t\n\r]+                   /* ignore tab and whitesapce*/;
\/\/[^\n\r]*              /*One line comments.  Does not count as a line*/ ;

"debut" {output("tDEBUT"); return tDEBUT;}
"fin" {output("tFIN"); return tFIN;}
"definir" {output("tDEFINIR"); return tDEFINIR;}
"comme" {output("tCOMME"); return tCOMME;}
"un" {output("tUN"); return tUN;}
"une" {output("tUNE"); return tUNE;}
"avec valeur" {output("tAVECVALEUR"); return tAVECVALEUR;}
"entier" {output("tQUANTITY"); return tQUANTITY;}
"afficher" {output("tAFFICHER"); return tAFFICHER;}
"valeur de" {output("tVALEURDE"); return tVALEURDE;}

"." {output("."); return '.';}

0|([1-9][0-9]*) {
    yylval.int_lit = atoi(yytext);

    fprintf(fd,"tINTLITERAL(%s)\n",yytext);
    return tINTLITERAL;
}

[a-zA-Z_][a-zA-Z0-9_]* {
   yylval.string_lit = strdup(yytext);
    fprintf(fd,"tIDENTIFIER(%s)\n",yytext);
    sprintf(yylval.string_lit,"%s",yytext); 
    return tIDENTIFIER;
}

. {fprintf(stderr, "Erreur: (ligne %d) lettre inatendu '%s'\n", yylineno, yytext); exit(1);}
%%
