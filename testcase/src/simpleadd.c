#include "trap.h"

int main() {
	int o,q;
	o=1+2;
	o=1-2;
	q=0-2147483647;
	q=q-1;
	o=q-1;
	o=0-q;
	o=2147483647+q;
	o=o+2147483647;
	q=2147483647;
	o=q+1;
	++o;
	--o;
	o++;
	o--;
	o=q-0;
	float a=2,b=3;

while(1);
	HIT_BAD_TRAP;

	return 0;
}
