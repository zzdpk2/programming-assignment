#include "common.h"
#include "nemu.h"
#include "memory/page.h"
#include "memory/memory.h"
#include "memory/tlb.h"
extern CPU_state cpu;
extern tlb_t tlb;
//Translate from leaner address to hardware address
hwaddr_t page_translate(lnaddr_t addr)
{
	if(cpu.cr0.paging==0)return addr;//Page not enabled
	linear_paged_addr_t tmp;
	tmp.val=addr;
	//If tlb is enabled, try to find in tlb first.
#ifdef USE_TLB
	bool success;
	uint32_t data=find_tlb(tlb,addr>>PAGE_OFFSET_LEN,&success);
	if(success)//Hit TLB
	{
		return (data<<PAGE_OFFSET_LEN)+tmp.offset;
	}
#endif
	PTE pte;
	hwaddr_t base;
	base=cpu.cr3.val & 0xfffff000;//Get PAGE DIRECTORY start position
	pte.val=hwaddr_read(base+tmp.dir*4,4);
	if(!pte.present)
	{

		printf("Level 1 Page Miss!\nLnaddr:[%x]\n",addr);
		fflush(stdout);
		page_info(addr);
		//Kill the program immediately.
		assert(0);
	}
	base=pte.page_frame << PAGE_OFFSET_LEN;
	pte.val=hwaddr_read(base+tmp.page*4,4);
	if(!pte.present)
	{
		printf("Level 2 Page Miss!\nLnaddr:[%x]\n",addr);
		fflush(stdout);
		page_info(addr);
		//Kill the program immediately.
		assert(0);
		
	}
#ifdef USE_TLB
	write_tlb(tlb, addr>>PAGE_OFFSET_LEN, pte.page_frame);
#endif
	return (pte.page_frame<<PAGE_OFFSET_LEN)+tmp.offset;
}
//Print page information of a leaner address
//Used by monitor debug command 'page'
void page_info(lnaddr_t addr)
{
	printf("=======================\nlnaddr:\t0x%X\n",addr);
	if(cpu.cr0.paging==0)
	{
		printf("Note: Paging not enabled!\n");
		printf("hwaddr:\t0x%X\n",addr);
		return;
	}
	linear_paged_addr_t tmp;
	tmp.val=addr;
	PTE pte;
	printf("dir:\t0x%X\tpage:\t0x%X\toffset:\t0x%X\n",tmp.dir,tmp.page,tmp.offset);
#ifdef USE_TLB
	bool success;
	uint32_t data=find_tlb(tlb,addr>>PAGE_OFFSET_LEN,&success);
	if(success)//Hit TLB
	{
		printf("TLB Hit!Data:\t0x%X\n",data);
	}
	else
	{
		printf("TLB Miss!\n");
	}
#endif
	hwaddr_t base;
	base=cpu.cr3.val & 0xfffff000;//Get PAGE DIRECTORY start position
	pte.val=hwaddr_read(base+tmp.dir*4,4);
	printf("First Level Paging:\n");
	printf("Present:\t%c\n",pte.present?'Y':'N');
	if(!pte.present)return;
	printf("Frame:\t0x%X\n",pte.page_frame);
	base=pte.page_frame << PAGE_OFFSET_LEN;
	pte.val=hwaddr_read(base+tmp.page*4,4);
	printf("Second Level Paging:\n");
	printf("Present:\t%c\n",pte.present?'Y':'N');
	if(!pte.present)return;
	printf("Frame:\t0x%X\n",pte.page_frame);
	printf("hwaddr:\t0x%X\n",(pte.page_frame<<PAGE_OFFSET_LEN)+tmp.offset);

}