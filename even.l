
%{
int i = 0; 
int even = 0;
%}

%%

[0-9]+     {i=atoi(yytext); 
            if(i%2==0 )  
               even++; 
         } 
\n		{  }

%%
int yywrap(){}

int main()
{
  yylex();
  printf("%d\n", even);
  return 0;
}

