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
    mov $0, %ebp
    mov $0x08000000, %esp
    sub $0x10, %esp
    mov %esp, %esi
    
    call func1
    push %eax
    push %ecx
    push %edx
    push %ebx
    call func2
    call func3
    
    cmp %esp, %esi
    je test_ok
    HIT_BAD_TRAP
    
func1:
    push %eax
    push %ecx
    push %edx
    push %ebx
    pop %eax
    pop %eax
    pop %eax
    pop %eax
    xor %eax, %eax
    ret
    HIT_BAD_TRAP

func2:
    push %eax
    pop %eax
    push %eax
    pop %eax
    ret $16
    HIT_BAD_TRAP

func3:
    push %eax
    push %ecx
    push %edx
    push %ebx
    call func2
    xor %eax, %eax
    ret
    HIT_BAD_TRAP

test_ok:
    HIT_GOOD_TRAP
test_fail:
    HIT_BAD_TRAP
    HIT_BAD_TRAP
    HIT_BAD_TRAP
    
