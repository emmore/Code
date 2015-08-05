#include<stdio.h>
char input[2048];
int main()
{
	puts("Lisp Version 0.00\n");
	puts("Press Ctrl+C to Exit\n");

	while(1)
	{
		fputs("lispy>",	stdout);
		fgets(input,2048,stdin);

		printf("No, u r a %s",input);
	}
	return 0;
}
