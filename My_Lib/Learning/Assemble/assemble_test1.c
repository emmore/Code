#include<stdio.h>
int main()
{
	int add();
	int t1;
	int t2;
	int s;
	t1=1;
	t2=2;
	s=add(t1,t2);
	printf("the result is %d\n",s);
}

int add(int t1, int t2)
{
	int result;
	result=t1+t2;
	return result;
}
	
