%{
    int currentYear = 21; //the current year - 2000
    int newStart = 13;
%}

OLDYEAR [0189][0-9]
NEWCOUNTY C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW

NEWYEAR ([0-9]{2}[1-2])
OLDCOUNTY C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW

REGNUMBER ([1-9][0-9]{0,5})

IGNORESTUFF (\n|.)

%%
{IGNORESTUFF}   {}
{OLDYEAR}(-){OLDCOUNTY}(-){REGNUMBER} {
                                        char yearStr[] = {yytext[0], yytext[1], '\0'}; 
                                        int year = atoi(yearStr);
                                        if(year >= 87)
                                            printf("%d\n", (100-year)+currentYear);
                                        else if(year <= 12)
                                            printf("%d\n", currentYear-year);
                                        else
                                            printf("INVALID\n");
                                    }

{NEWYEAR}(-){NEWCOUNTY}(-){REGNUMBER} {
                                        char yearStr[] = {yytext[0], yytext[1], '\0'}; 
                                        int year = atoi(yearStr);
                                        if(year >= newStart && year <= currentYear)
                                            printf("%d\n", currentYear-year);
                                        else
                                            printf("INVALID\n");
                                    }

([0-9]*"-"*[a-zA-Z]*"-"*[0-9]*)*    {printf("INVALID\n");}
%%

int main(){
    yylex();
}