org 100h

    MOV DX, 2000h
    MOV BX, 0

MAZE:

    MOV SI, 0
    MOV CX, 5

NEXT:
	MOV AL,INIT[BX][SI]
	out dx,al
	INC SI
	INC DX

	CMP SI, 5
	LOOPNE NEXT
    
    ADD BX, 5
	CMP BX, 40
	JL MAZE

MOV DX, 2000h

MOV AL,POINT
out dx,al

PUSH DX

MAINLOOP: MOV AH, 00h
          int 16h
          
          cmp al, 0Dh
          je stop_input
          
          cmp ah, 50h
          je downwards
          
          cmp ah, 48h
          je upwards
          
          cmp ah, 4Dh
          je right
          
          cmp ah, 4Bh
          je left
          
          loop MAINLOOP
          
          


downwards:
    POP DX
    
    MOV AX, 00h
    MOV AL, POINT
    
    CMP AL, 40h;64 in Binary
    je push_for_downwards
    
    
    MOV DI, DX
    ADD DI, -2000h 
    
    ROL AL, 1
    
    MOV BX, 00h
    MOV CX, 7
    
    sar_point_for_downwards:
        INC BX         
        SAR AL, 1
        JC is_full_for_downwards
    loop sar_point_for_downwards    
                       
    
    is_full_for_downwards:
        MOV CX, BX
        MOV AL,INIT[DI]
        SAR AL, CL           
        JC push_for_downwards
     
    MOV BL, POINT
    ROL BL, 1
             
    PUSH DI         
             
    MOV AL, BL
    LEA DI, POINT
    STOSB
    
    POP DI
    
    MOV AL, INIT[DI]   
    ADD AL, BL
    out dx,al
       
    push_for_downwards:
        PUSH DX
    
jmp MAINLOOP
    
    
    
upwards:
    POP DX
    
    MOV AX, 00h
    MOV AL, POINT
    
    CMP AL, 1h;1 in Binary
    je push_for_upwards


    MOV DI, DX
    ADD DI, -2000h 
    
    MOV BL, AL
    SAR BL, 1
    
    MOV AL, BL
    
    MOV BX, 00h
    MOV CX, 7
    
    sar_point_for_upwards:
        INC BX         
        SAR AL, 1
        JC is_full_for_upwards
    loop sar_point_for_upwards    
                       
    
    is_full_for_upwards:
        MOV CX, BX
        MOV AL,INIT[DI]
        SAR AL, CL           
        JC push_for_upwards
     
    MOV BL, POINT
    SAR BL, 1
             
    PUSH DI         
             
    MOV AL, BL
    LEA DI, POINT
    STOSB
    
    POP DI
    
    MOV AL, INIT[DI]   
    ADD AL, BL
    out dx,al
       
    push_for_upwards:
        PUSH DX
    
jmp MAINLOOP
    
right:
    POP DX
    
    CMP DX, 2027h;End
    je push_for_right


    MOV DI, DX
    ADD DI, -2000h 
    
    MOV AL, POINT
    
    MOV BX, 00h
    MOV CX, 7
    
    sar_point_for_right:
        INC BX         
        SAR AL, 1
        JC is_full_for_right
    loop sar_point_for_right    
                       
    
    is_full_for_right:
        MOV CX, BX
        MOV AL,INIT[DI+1]
        SAR AL, CL           
        JC push_for_right
     
    
	MOV AL,INIT[DI]
	out dx,al
	
	INC DX
	
    MOV AL, POINT   
    ADD AL, INIT[DI+1]
    out dx,al
       
    push_for_right:
        PUSH DX
    
jmp MAINLOOP
    
left: 
    POP DX
    
    CMP DX, 2000h;Begin
    je push_for_left
    
    MOV DI, DX
    ADD DI, -2000h 
    
    LEA SI, POINT
    LODSB
    
    MOV BX, 00h
    MOV CX, 7
    
    sar_point_for_left:
        INC BX         
        SAR AL, 1
        JC is_full_for_left
    loop sar_point_for_left    
                       
    
    is_full_for_left:    
        MOV CX, BX
        MOV AL,INIT[DI-1]
        SAR AL, CL   
        JC push_for_left
     
    
	MOV AL,INIT[DI]
	out dx,al
	
	DEC DX
	
    MOV AL, POINT 
    ADD AL, INIT[DI-1]
    out dx,al
       
    push_for_left:
        PUSH DX
    
jmp MAINLOOP
   

stop_input: 
    POPA  
	
ret

INIT DB 0000000B, 0000000B, 0000000B, 0000000B, 0000000B, 1110111B, 1000001B, 1111001B, 1111011B, 1000001B, 1011111B, 1011111B, 1010001B, 1010101B, 1000101B, 1111101B, 1000101B, 1010001B, 1010101B, 1010101B, 1100011B, 1000001B, 1011101B, 1011101B, 1011101B, 1001001B, 1000101B, 1011101B, 1100001B, 1101111B, 1000001B, 1010101B, 1010101B, 1010101B, 1111101b, 0000000B, 0000000B, 0000000B, 0000000B, 0000000B

POINT DB 0001000B 