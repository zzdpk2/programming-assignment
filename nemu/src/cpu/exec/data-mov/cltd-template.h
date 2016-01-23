#include "cpu/exec/template-start.h"


#if DATA_BYTE == 2 || DATA_BYTE == 4
make_helper(concat(cltd_a_, SUFFIX)) {

	REG(2)=(DATA_TYPE_S)REG(0)>=0?0:-1;
	print_asm(DATA_BYTE == 4?"cltd":"cwtl");
	return 1;
}
#endif

#include "cpu/exec/template-end.h"
