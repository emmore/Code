#include<stdio.h>
int Palindrome(int c)
{
	int i,j;
	int t[8];
	int result=0;
	j=0;
	for(i=0;c>0;i++)
	{
		t[i]=c%10;
		c=(c-t[i])/10;
		j++;
	}
	for(i=0;i<j/2;i++)
	{
		if (t[i]!=t[j-i-1])
			result=1;
	}
	return result;
}

int main()
{
	int a,b,c;
	int result;
	for(a=101;a<1000;a++)
	{
		for(b=100;b<a;b++)
		{
			c=a*b;
			if((Palindrome(c)==0) && (c>result))
			{
				result=c;
			}
		}
	}
	printf("%d\n",result);
	return 0;
}
