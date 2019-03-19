org 0x7c00
jmp 0x0000:start

entrada db 'o'
entrada2 db 'w'
entrada3 db 'V'

start:
    call reset_register
    jmp self_loop

reset_register:
    xor ax, ax
    mov dx, ax
    xor cl, cl
    xor dl, dl;
    xor bx, bx
    ret

getchar:
    mov ah, 0
    int 16h
    ret

_putchar:
    mov ah, 0eh
    int 10h

    ret

deleta:
    cmp cl, 0;
    je self_loop;
    dec cl;
    dec di
    mov byte[di], 0

    mov al, 0x08
    call _putchar
    mov al, ''
    call _putchar
    mov al, 0x08
    call _putchar



    jmp self_loop;

self_loop:
    call getchar;
    cmp al, 0x0d;
    je transnum;
    cmp al, 0x08;
    je deleta;
    inc cl;
    call _putchar;
    sub al, 48;
    stosb
    
    
    
    jmp self_loop;

endl:
    mov al, 0x0a
    call _putchar
    mov al, 0x0d
    call _putchar
    ret

transnum:
    call endl;
    lodsb
    mov dh, 0
    mov dl, al;
    dec cl
    cmp cl, 0;
    je calcular;
    jmp gambi;

gambi:
    xor ax, ax
    mov bx, 10
    cmp cl,0;
    je calcular;
    mov ax, dx
    mul bx
    mov dx, ax
    xor ax, ax
    lodsb
    add dx, ax
    dec cl;
    jmp gambi;
calcular:
    xor bx, bx;
    mov bx, dx;
    xor ax,ax;
    xor cx, cx;
    jmp resultado;

resultado:
    mov ax, bx ;meu n ta no bx e no ax
    mul ax; ax = n*n
    add ax, bx ; ax = (n*n)+n
    mov cx, 2; cx = 2; 
    div cx; ax = ((n*n)+n)/2

    mov bx, ax
    mov cx, ax
    mov dx, ax
    jmp mostrar

mostrar:
    xor cx, cx;
    jmp numbre;

numbre:
    mov ax, bx; ax e dx tem o numero
    mov bx, 10;
    xor dx, dx
    ;
    ;
    ;

    div bx; divido por 10
    ;
    ;
    ;
    ;

    add dx, '0';
    push dx;
    xor dx, dx;
    inc cl;
    mov bx, ax;
    cmp ax, 0;
    je ajustes;
    jmp numbre;

ajustes:
    mov ch,cl;
    cmp ch, 3;
    jmp reverter

reverter:
    xor ax,ax
    cmp cl, 0;
    je telinha_vitoria
    pop ax;
    call _putchar
    dec cl;
    stosb;
    jmp reverter;

telinha_vitoria:
    cmp ch, 0
    je exit;
    xor ax, ax;
    lodsb
    dec ch;
    jmp telinha_vitoria;

shupa:
    xor si, si
    mov si, entrada;
    call printa;
    ret

delicia:
    xor si, si
    mov si, entrada3
    call printa2
    ret

fuck:
    xor si, si
    mov si, entrada2
    call printa2
    ret
printa:
    lodsb
    mov ah, 0eh;
    int 10h
    ret
printa2:
    lodsb
    mov ah, 0eh;
    int 10h
    ret
exit:
    jmp $
    times 510 - ($-$$) db 0
    dw 0xaa55
