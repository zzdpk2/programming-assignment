#include "cpu/exec/template-start.h"

#define instr pop
/*
#if DATA_BYTE == 2 || DATA_BYTE == 4
make_helper(concat(push_reg_, SUFFIX)) {
	uint32_t regid = instr_fetch(eip, 1)-0x50;
	push_data(REG(regid),DATA_BYTE);
	print_asm("push %%%s", REG_NAME(regid));
	return 1;
}
#endif*/
#if DATA_BYTE == 2 || DATA_BYTE == 4
static void do_execute() {
	if(op_src->type==OP_TYPE_MEM)
		pop_data(op_src->addr,DATA_BYTE);
	else
		pop_data(REG(op_src->reg),DATA_BYTE);

	print_asm_template1();
}
make_instr_helper(rm)
make_instr_helper(r)
#endif



#include "cpu/exec/template-end.h"
