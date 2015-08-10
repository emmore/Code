#include<stdio.h>
int main()
{
	int a, b ,c;
	for(a=1;a<333;a++)
	{
		for(b=a+1;b<1000-2*a;b++)
		{
			for(c=b;c<1000;c++)
			{
				if(a+b+c==1000&&a*a+b*b==c*c)
				{
					printf("%d\n",a);
					printf("%d\n",b);
					printf("%d\n",c);
					printf("%d\n",a*b*c);
				}
			}
		}
	}
	return 0;
}
