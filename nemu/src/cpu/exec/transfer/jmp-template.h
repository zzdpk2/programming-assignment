#include "cpu/exec/template-start.h"

#define instr jmp

#if DATA_BYTE == 2 || DATA_BYTE ==4
static void concat(do_execute,direct)(uint32_t len)
{
	cpu.eip=op_src->val-len;
#if DATA_BYTE==2
	cpu.eip&=0xFFFF;
#endif
#ifdef DEBUG
	swaddr_t newop=cpu.eip+len;
#if DATA_BYTE==2
	newop&=0xFFFF;
#endif
	extern char *PrintAddressInFunction(swaddr_t,bool);//elf.c
	char *infun=PrintAddressInFunction(newop,true);
	if(infun)
		print_asm("jmp %x %s", newop,infun);
	else
		print_asm("jmp %x", newop);
#endif

}
#endif

static void concat(do_execute,relative)(uint32_t len) 
{
	cpu.eip=cpu.eip+(DATA_TYPE_S)op_src->val;
#if DATA_BYTE==2
	cpu.eip&=0xFFFF;
#endif
#ifdef DEBUG
	swaddr_t newop=cpu.eip+len;
#if DATA_BYTE==2
	newop&=0xFFFF;
#endif
	extern char *PrintAddressInFunction(swaddr_t,bool);//elf.c
	char *infun=PrintAddressInFunction(newop,true);
	if(infun)
		print_asm("jmp %x %s", newop,infun);
	else
		print_asm("jmp %x", newop);
#endif
}

#if DATA_BYTE == 2 || DATA_BYTE ==4
make_instr_helper2(rm,direct)
#endif
make_instr_helper2(i,relative)



#include "cpu/exec/template-end.h"
