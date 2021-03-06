/*
The MIT License (MIT)

Copyright (c) 2015 Zhang Boyang

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

#include "trap.h"

.globl start
start:
    mov $0x08000000, %esp
    sub $0x10, %esp


    mov $0xabcd1234, %eax
    and $2, %eax
    mov $0xabcd1234, %eax
    and $2, %ax
    mov $0xabcd1234, %eax
    and $2, %ah
    mov $0xabcd1234, %eax
    and $2, %al
    mov $0xabcd1234, %eax
    and $0xaabbccdd, %eax
    mov $0xabcd1234, %ebx
    and $0xaabbccdd, %ebx
    mov $0xabcd1234, %ebx
    and $0xaabb, %bx
    mov $0xaabb, %eax
    mov $0xabcd1234, %ebx
    and %al, %bl
    mov $0xabcd1234, %ebx
    and %ax, %bx
    mov $0xabcd1234, %ebx
    and %eax, %ebx
    movl $0xaabbccdd, (%esp)
    mov $0xabcd1234, %ebx
    andb (%esp), %bl
    mov $0xabcd1234, %ebx
    andw (%esp), %bx
    mov $0xabcd1234, %ebx
    andl (%esp), %ebx

    mov $0xabcd1234, %eax
    xor $2, %eax
    mov $0xabcd1234, %eax
    xor $2, %ax
    mov $0xabcd1234, %eax
    xor $2, %ah
    mov $0xabcd1234, %eax
    xor $2, %al
    mov $0xabcd1234, %eax
    xor $0xaabbccdd, %eax
    mov $0xabcd1234, %ebx
    xor $0xaabbccdd, %ebx
    mov $0xabcd1234, %ebx
    xor $0xaabb, %bx
    mov $0xaabb, %eax
    mov $0xabcd1234, %ebx
    xor %al, %bl
    mov $0xabcd1234, %ebx
    xor %ax, %bx
    mov $0xabcd1234, %ebx
    xor %eax, %ebx
    movl $0xaabbccdd, (%esp)
    mov $0xabcd1234, %ebx
    xorb (%esp), %bl
    mov $0xabcd1234, %ebx
    xorw (%esp), %bx
    mov $0xabcd1234, %ebx
    xorl (%esp), %ebx
    
    mov $0xabcd1234, %eax
    or $2, %eax
    mov $0xabcd1234, %eax
    or $2, %ax
    mov $0xabcd1234, %eax
    or $2, %ah
    mov $0xabcd1234, %eax
    or $2, %al
    mov $0xabcd1234, %eax
    or $0xaabbccdd, %eax
    mov $0xabcd1234, %ebx
    or $0xaabbccdd, %ebx
    mov $0xabcd1234, %ebx
    or $0xaabb, %bx
    mov $0xaabb, %eax
    mov $0xabcd1234, %ebx
    or %al, %bl
    mov $0xabcd1234, %ebx
    or %ax, %bx
    mov $0xabcd1234, %ebx
    or %eax, %ebx
    movl $0xaabbccdd, (%esp)
    mov $0xabcd1234, %ebx
    orb (%esp), %bl
    mov $0xabcd1234, %ebx
    orw (%esp), %bx
    mov $0xabcd1234, %ebx
    orl (%esp), %ebx

    mov $0xabcd1234, %eax
    test $2, %eax
    mov $0xabcd1234, %eax
    test $2, %ax
    mov $0xabcd1234, %eax
    test $2, %ah
    mov $0xabcd1234, %eax
    test $2, %al
    mov $0xabcd1234, %eax
    test $0xaabbccdd, %eax
    mov $0xabcd1234, %ebx
    test $0xaabbccdd, %ebx
    mov $0xabcd1234, %ebx
    test $0xaabb, %bx
    mov $0xaabb, %eax
    mov $0xabcd1234, %ebx
    test %al, %bl
    mov $0xabcd1234, %ebx
    test %ax, %bx
    mov $0xabcd1234, %ebx
    test %eax, %ebx
    movl $0xaabbccdd, (%esp)
    mov $0xabcd1234, %ebx
    testb (%esp), %bl
    mov $0xabcd1234, %ebx
    testw (%esp), %bx
    mov $0xabcd1234, %ebx
    testl (%esp), %ebx
    
    mov $0xabcd1234, %eax
    cmp $2, %eax
    mov $0xabcd1234, %eax
    cmp $2, %ax
    mov $0xabcd1234, %eax
    cmp $2, %ah
    mov $0xabcd1234, %eax
    cmp $2, %al
    mov $0xabcd1234, %eax
    cmp $0xaabbccdd, %eax
    mov $0xabcd1234, %ebx
    cmp $0xaabbccdd, %ebx
    mov $0xabcd1234, %ebx
    cmp $0xaabb, %bx
    mov $0xaabb, %eax
    mov $0xabcd1234, %ebx
    cmp %al, %bl
    mov $0xabcd1234, %ebx
    cmp %ax, %bx
    mov $0xabcd1234, %ebx
    cmp %eax, %ebx
    movl $0xaabbccdd, (%esp)
    mov $0xabcd1234, %ebx
    cmpb (%esp), %bl
    mov $0xabcd1234, %ebx
    cmpw (%esp), %bx
    mov $0xabcd1234, %ebx
    cmpl (%esp), %ebx
    
	HIT_GOOD_TRAP

