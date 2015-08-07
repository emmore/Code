#define KK 600851475143
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
	int i;
	int result;
	long int N;
	N=KK;
	for (i=2;i<sqrt(KK);i++)
	{
		while(N%i==0)
		{
			N=N/i;
			result=i;
		}
	}
	printf("%d\n",result);
	return 0;
}
