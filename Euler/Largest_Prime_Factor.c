#define KK 600851475143
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
	int i;
	long int N;
	N=KK;
	for (i=2;i<sqrt(N)&&(N%i!=0);i++)
	{
		N=N/i;
		printf("%d\n",i);
	}
	printf("%d\n",i);
	return 0;
}
