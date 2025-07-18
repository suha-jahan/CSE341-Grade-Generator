.MODEL SMALL
 
.STACK 100H

.DATA 
newline db 0Ah,0Dh,"$"

m1 db "Welcome to CSE341 Grade Generator!$"
m2 db "Enter Student Name: $"
m3 db "Enter Student ID: $"
m4 db "Enter Section: $"
m5 db "Enter Faculty Initials: $"
m6 db "Enter Semester: $"

attendance_m7 db "Enter Attendance Marks (Out of 5): $"
assignment_m8 db "Enter Assignment Marks (Out of 5): $"
quiz_m9 db "Enter Quiz Marks (Out of 10): $"
mid_m10 db "Enter Mid Marks (Out of 25): $"
final_m11 db "Enter Final Marks (Out of 30): $"
lab_m12 db "Enter Lab Marks (Out of 25): $"
totalMarks_m13 db "Your total mark is: $"
grade_m14 db "Your grade for CSE341 is: $"
invalid_input1 db "Invalid input. Please enter a valid number between 0-5.$"
invalid_input2 db "Invalid input. Please enter a valid number between 0-10.$"
invalid_input3 db "Invalid input. Please enter a valid number between 0-25.$"
invalid_input4 db "Invalid input. Please enter a valid number between 0-30.$"
new_student db "Do you want to add a new student? if yes type 'y' if no type 'n': $"
endMsg db "The end!$"

output1 db "Calculating total marks...$"
output2 db "Calculating your grade...$"

A db "Excellent performance! Keep it up!$"
A_m db "Outstanding work! Well done.$"
B_p db "Very good work!$"
B db "Good job!$"
B_m db "Not bad..A little more work needed.$"
C_p db "Fair performance,room for improvement.$"
C db "Average performance, try harder and you'll do great.$"
C_m db "Below average,improvement is required. You got this!$"
D_p db "Passed! But improvement is required.$"
D db "Just passed... A lot of hard work and improvement is necessary.$"
F db "Failed. However, it is not the end of the world.Try again.$"

name db 30,0
id db 10,0
section db 5,0
fac_initials db 6,0
semester db 5,0
attendance db ?
assignment db ?
quiz db ?
mid db ?
final db ?
lab db ? 
total db 0
grade db ?

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
;------------------------------------DISPLAY MSG,NAME,ID,SECTION,FAC,SEMESTER----------------------------------------------------
input_student_data:

mov ah,9  ;display m1
lea dx,m1
int 21h

mov ah,9    ;skip 2 lines
lea dx,newline
int 21h
mov ah,9
lea dx,newline
int 21h

mov ah,9  ;student name display
lea dx,m2
int 21h    
mov ah,10
int 21h

mov ah,9    ;new line
lea dx,newline
int 21h  

mov ah,9   ;student ID display
lea dx,m3
int 21h
lea dx,id
mov ah,10
int 21h 

mov ah,9    ;new line
lea dx,newline
int 21h  

mov ah,9   ;student section display
lea dx,m4
int 21h
lea dx,section
mov ah,10
int 21h  

mov ah,9    ;new line
lea dx,newline
int 21h  

mov ah,9   ;student fac initials display
lea dx,m5
int 21h
lea dx,fac_initials
mov ah,10
int 21h  

mov ah,9    ;new line
lea dx,newline
int 21h  

mov ah,9   ;student semester display
lea dx,m6
int 21h
lea dx,semester
mov ah,10
int 21h  

mov ah,9    ;new line
lea dx,newline
int 21h  

;----------------------------------------------MARKS INPUT & VALIDATE---------------------------------------------------------

;------------------------------------------ATTENDANCE INPUT AND VALIDATE------------------------------------------------------
attendance_input:  
mov ah,9                          ;student attendance display
lea dx,attendance_m7
int 21h                           ;1 digit input
mov ah,1
int 21h  

;attendance validation
cmp al,'0'
jl invalid_attendance             ;check input is a digit
cmp al,'9'
jg invalid_attendance
sub al,30h
cmp al,5                          ;input>5 
jg invalid_attendance
mov attendance,al
jmp take_attendance

invalid_attendance:
    mov ah,9                      ;new line 
    lea dx,newline
    int 21h
    mov ah,9
    lea dx,invalid_input1
    int 21h
    mov ah,9                      ;new line
    lea dx,newline
    int 21h
    jmp attendance_input
    
take_attendance:
mov ah,9                   ;new line
lea dx,newline
int 21h  

;------------------------------------------ASSIGNMENT INPUT AND VALIDATE-----------------------------------------------------
assignment_input:
mov ah,9                    ;student assignment display
lea dx,assignment_m8
int 21h
mov ah,1                      ;1 digit input
int 21h  

;assignment validation
cmp al,'0'                     ;check if digit
jl invalid_assignment
cmp al,'9'
jg invalid_assignment          ;check>5
sub al,30h
cmp al,5
jg invalid_assignment
mov assignment,al
jmp take_assignment

invalid_assignment:
    mov ah,9                     ;new line 
    lea dx,newline
    int 21h
    mov ah,9
    lea dx,invalid_input1
    int 21h
    mov ah,9                     ;new line 
    lea dx,newline
    int 21h
    jmp assignment_input
    
take_assignment:
mov ah,9                    ;new line
lea dx,newline
int 21h  

;------------------------------------------QUIZ INPUT AND VALIDATE-----------------------------------------------------
quiz_input:
mov ah,9                           ;quiz display
lea dx,quiz_m9
int 21h
mov ah,1                            ;1st digit input 
int 21h   

;quiz validation
;check 1st digit is digit
cmp al,'0'
jl invalid_quiz
cmp al,'9'
jg invalid_quiz
sub al,30h
mov bl,al                            ;2nd digit input
mov ah,1
int 21h
cmp al,0Dh
je check_single_quiz_digit 

;check 2nd digit is digit
cmp al,'0'
jl invalid_quiz
cmp al,'9'
jg invalid_quiz
sub al,30h
mov cl,al
mov al,bl
mov bl,10
mul bl
add al,cl
cmp al,10                         ;check quiz>10
jg invalid_quiz
jmp quiz1 

check_single_quiz_digit:
mov al,bl 

quiz1:
mov quiz,al
jmp take_quiz

invalid_quiz:
    mov ah,9                           ;new line 
    lea dx,newline
    int 21h
    mov ah,9
    lea dx,invalid_input2
    int 21h
    mov ah,9                           ;new line 
    lea dx,newline
    int 21h
    jmp quiz_input
    
take_quiz:
mov ah,9                               ;new line
lea dx,newline
int 21h  

;------------------------------------------MID INPUT AND VALIDATE-----------------------------------------------------
mid_input:
lea dx,mid_m10                     ;mid display
int 21h 
mov ah,1                             ;1st digit input
int 21h  

;mid validation
;check 1st digit is digit
cmp al,'0'
jl invalid_mid
cmp al,'9'
jg invalid_mid
sub al,30h
mov bl,al                        ;2nd digit input
mov ah,1
int 21h
cmp al,0Dh
je check_single_mid_digit: 

;check 2nd digit is digit
cmp al,'0'
jl invalid_mid
cmp al,'9'
jg invalid_mid
sub al,30h
mov cl,al
mov al,bl
mov bl,10
mul bl
add al,cl
cmp al,25                        ;check mid>25
jg invalid_mid
jmp mid1 

check_single_mid_digit:
mov al,bl 

mid1:
mov mid,al
jmp take_mid

invalid_mid:
    mov ah,9                         ;new line
    lea dx,newline
    int 21h
    mov ah,9
    lea dx,invalid_input3
    int 21h
    mov ah,9                           ;new line
    lea dx,newline
    int 21h
    jmp mid_input 
    
take_mid:
mov ah,9                               ;new line
lea dx,newline
int 21h  

;------------------------------------------FINAL INPUT AND VALIDATE-----------------------------------------------------
final_input:
mov ah,9                      ;student final display
lea dx,final_m11
int 21h                       ;1st digit input
mov ah,1
int 21h 

;final validation
;check 1st digit is digit
cmp al,'0'
jl invalid_final
cmp al,'9'
jg invalid_final
sub al,30h
mov bl,al                     ;2nd digit input
mov ah,1
int 21h
cmp al,0Dh
je check_single_final_digit:

;check 2nd digit is digit
cmp al,'0'
jl invalid_final
cmp al,'9'
jg invalid_final
sub al,30h
mov cl,al
mov al,bl
mov bl,10
mul bl
add al,cl
cmp al,30                          ; check final>30
jg invalid_final
jmp final1  

check_single_final_digit:
mov al,bl

final1:
mov final,al
jmp take_final 

invalid_final:
    mov ah,9                  ;new line
    lea dx,newline
    int 21h
    mov ah,9
    lea dx,invalid_input4
    int 21h
    mov ah,9                      ;new line 
    lea dx,newline
    int 21h
    jmp final_input
    
take_final:
mov ah,9    ;new line
lea dx,newline
int 21h  


;------------------------------------------LAB INPUT AND VALIDATE-----------------------------------------------------
lab_input:
mov ah,9                     ;student lab display
lea dx,lab_m12
int 21h                       ;1st digit input
mov ah,1
int 21h  

;lab validation
;check 1st digit is digit
cmp al,'0'
jl invalid_lab
cmp al,'9'
jg invalid_lab
sub al,30h
mov bl,al
mov ah,1                       ;2nd digit input
int 21h
cmp al,0Dh
je check_single_lab_digit:

;check 2nd digit is digit
cmp al,'0'
jl invalid_lab
cmp al,'9'
jg invalid_lab
sub al,30h
mov cl,al
mov al,bl
mov bl,10
mul bl
add al,cl
cmp al,25                     ;check lab>25
jg invalid_lab
jmp lab1    

check_single_lab_digit:
mov al,bl

lab1:
mov lab,al
jmp take_lab
invalid_lab:
    mov ah,9                     ;new line 
    lea dx,newline
    int 21h
    mov ah,9
    lea dx,invalid_input3
    int 21h
    mov ah,9                      ;new line
    lea dx,newline
    int 21h
    jmp lab_input
    
take_lab:
;--------------------------------------------DONE TAKING ALL THE INPUTS-------------------------------------------------------- 

mov ah,9    ;new line
lea dx,newline
int 21h    
mov ah,9    ;new line
lea dx,newline
int 21h

mov ah,9    ;display msg
lea dx,output1
int 21h

mov ah,9    ;new line
lea dx,newline
int 21h    
mov ah,9    ;new line
lea dx,newline
int 21h

mov ah,9    ;display total
lea dx,totalMarks_m13
int 21h 

;--------------------------------------------------------ADDITION--------------------------------------------------------------- 
addition:

mov al,0           
mov total,al       
mov al,attendance
add total,al       
mov al,assignment
add total,al       
mov al,quiz
add total,al       
mov al,mid
add total,al       
mov al,final
add total,al       
mov al,lab
add total,al

;------------------------------------------Display marks------------------------------------------------------------------------
mov al,total       
mov ah,0           

cmp ax,100           ;100s place value
jl no_hundreds       ;if not 100
mov bl,100         
div bl             
mov dl,al         
add dl,30h         
push ax            
mov ah,2           
int 21h
pop ax             
mov al,ah          
mov ah,0         

no_hundreds:
mov bl,10          ;10s place value
div bl             
mov dl,al         
add dl,30h         
push ax            
mov ah,2           
int 21h
pop ax
mov al,ah          
                    
mov dl,al           ;1s place value
add dl,30h         
mov ah,2
int 21h
;-------------------------------------------------ADDITION DONE!-----------------------------------------------------------------
;-------------------------------------------------GRADE DISPLAY------------------------------------------------------------------
mov ah,9    ;new line
lea dx,newline
int 21h
mov ah,9    ;new line
lea dx,newline
int 21h    

mov ah,9    ;display msg
lea dx,output2
int 21h 

mov ah,9    ;new line
lea dx,newline
int 21h
mov ah,9    ;new line
lea dx,newline
int 21h 

mov ah,9    ;display grade
lea dx,grade_m14
int 21h   
;-------------------------------------------------CHECKING GRADES----------------------------------------------------------------
;----------------------------------------------------FEEDBACK--------------------------------------------------------------------

mov al,total     

cmp al,90           ;For A
jb Aminus
mov dl,'A'           ;grade
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,A
int 21h
jmp exit

Aminus:              ;For A-
cmp al,85
jb Bplus
mov dl,'A'
mov ah,2
int 21h
mov dl,'-'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,A_m
int 21h
jmp exit

Bplus:                 ;For B+
cmp al,80
jb Bplain
mov dl,'B'
mov ah,2
int 21h
mov dl,'+'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,B_p
int 21h
jmp exit

Bplain:                 ;For B
cmp al,75
jb Bminus
mov dl,'B'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,B
int 21h
jmp exit

Bminus:                 ;For B-
cmp al,70
jb Cplus
mov dl,'B'
mov ah,2
int 21h
mov dl,'-'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,B_m
int 21h
jmp exit

Cplus:                ;For C+
cmp al,65
jb Cplain
mov dl,'C'
mov ah,2
int 21h
mov dl,'+'
mov ah,2
int 21h 
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,C_p
int 21h
jmp exit

Cplain:                ;For C
cmp al,60
jb Cminus
mov dl,'C'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,C
int 21h
jmp exit

Cminus:                ;For C-
cmp al,57
jb Dplus
mov dl,'C'
mov ah,2
int 21h
mov dl,'-'
mov ah,2
int 21h 
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,C_m
int 21h
jmp exit

Dplus:              ;For D+
cmp al,55
jb Dplain
mov dl,'D'
mov ah,2
int 21h
mov dl,'+'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,D_p
int 21h
jmp exit

Dplain:                  ;For D
cmp al,50
jb Fgrade
mov dl,'D'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,D
int 21h
jmp exit

Fgrade:                  ;For F
mov dl,'F'
mov ah,2
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9           ;feedback
lea dx,F
int 21h

exit:
;---------------------------------------------DONE CHECKING GRADES---------------------------------------------------------------

;----------------------------------------------Another student input-------------------------------------------------------- ----
mov ah,9    ;skip 2 lines
lea dx,newline
int 21h
mov ah,9
lea dx,newline
int 21h 
 
mov ah,9
lea dx,new_student
int 21h

mov ah,1
int 21h
cmp al, 'y'
mov ah,9
lea dx,newline
int 21h    
je input_student_data
cmp al, 'Y'
mov ah,9
lea dx,newline
int 21h    
je input_student_data 
cmp al, 'n' 
je the_end 
cmp al, 'N' 
je the_end

the_end:
mov ah,9    ;skip 2 lines
lea dx,newline
int 21h
mov ah,9
lea dx,newline
int 21h
mov ah,9
lea dx,endMsg
int 21h
;--------------------------------------------------------------------------------------------------------------------------------

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP 

END MAIN
    END MAIN




