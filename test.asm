fun4: cmpq %rsi, %rdi
setg %cl
cmpq %rdx, %rdi
setl %al
testb %al, %cl
je .L2
testb $1, %dil
jne .L3
leaq (%rdi,%rdx), %rax
ret
.L3:
movq %rsi, %rax
subq %rdx, %rax
ret
.L2:
cmpq %rdx, %rdi
movq %rdx, %rax
cmovle %rdi, %rax
cmpq %rax, %rsi
jle .L5
movq %rdx, %rcx
shrq $63, %rcx
leaq (%rdx,%rcx), %rax
andl $1, %eax
subq %rcx, %rax
cmpq $1, %rax
je .L10
testq %rdi, %rdi
js .L11
movq %rdi, %rax
subq %rsi, %rax
ret
.L10:
movq %rsi, %rax
imulq %rdx, %rax
ret
.L11:
addq %rsi, %rdi
leaq (%rdi,%rdx), %rax
ret
.L5:
cmpq %rdx, %rdi
je .L12
cmpq %rdx, %rsi
jge .L9
subq %rsi, %rdx
leaq (%rdx,%rdi), %rax
ret
.L12:
imulq %rsi, %rdi
movq %rdi, %rax
imulq %rdx, %rax
ret
.L9:
addq %rsi, %rdi
movq %rdi, %rax
subq %rdx, %rax
ret
