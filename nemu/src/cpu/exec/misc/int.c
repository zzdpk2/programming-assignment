#include "cpu/exec/helper.h"
#include "cpu/decode/modrm.h"
#include <setjmp.h>
#include "memory/memory.h"
extern jmp_buf jbuf;

void raise_intr(uint8_t NO) {
	/* TODO: Trigger an interrupt/exception with ``NO''.
	 * That is, use ``NO'' to index the IDT.
	 */
	
	idtitem_t gate;
	lnaddr_t address=(uint32_t)NO*8+cpu.idtr_base;
	assert(address<cpu.idtr_limit+cpu.idtr_base);
	printf("%x\n",address);
	fflush(stdout);
	gate.item=lnaddr_read(address,4)+((uint64_t)lnaddr_read(address+4,4)<<32);
	uint32_t offset=gate.offset_15_0+(gate.offset_31_16<<16);


	segmentselector_t seg;
	seg.selector=gate.segment;
	gdtitem_t gdt;
	address=(uint32_t)seg.index*8+cpu.gdtr_base;
	assert(address<cpu.gdtr_limit+cpu.gdtr_base);
	gdt.item=lnaddr_read(address,4)+((uint64_t)lnaddr_read(address+4,4)<<32);
	uint32_t base=gdt.seg_base_0_15+((uint32_t)gdt.seg_base_16_23<<16)+((uint32_t)gdt.seg_base_24_31<<24);
	//inv->limit=gdt.seg_limit_0_15+((uint32_t)gdt.seg_limit_16_19<<16);


	printf("%x\n",gate.segment);
	fflush(stdout);
	cpu.eip=base+offset;
	/* Jump back to cpu_exec() */
	longjmp(jbuf, 1);
}

make_helper(int_i) {
	uint8_t id = instr_fetch(eip + 1, 1);
	raise_intr(id);
	print_asm("int $0x%X", id);
	return 2;
}