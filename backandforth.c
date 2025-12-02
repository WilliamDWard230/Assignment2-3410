// My incudes

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// my extern calls

extern int addstr(char* a, char* b);
extern int is_palindromeASM(char* s);
extern int factstr(char* s);
extern void palindrome_check();

//my funct decclarations
int fact(int n);
int is_palindromeC(char* s);

int main() {
    int choice; 
    char buffer[256];
    char num1[256] , num2[256];
    int result;

    while(1){
        printf("Menu: \n");
        printf("1) Add two numbers together \n");
        printf("2) Test if a string is a palindrome (C -> ASM) \n");
        printf("3) Print the factorial of a number \n");
        printf("4) Test if a string is a palindrome (ASM -> C) \n");
        printf("5) Exit \n\n");

        printf("Enter choice: ");

        if(scanf("%d", &choice) != 1){
            while(getchar() != '\n');
            continue;
        }
        while(getchar() != '\n');

        switch(choice){
            case 1:
                printf("Enter your first number: ");
                if(fgets(num1, sizeof(num1), stdin)==NULL){
                    break;
                }
                num1[strcspn(num1, "\n")] = '\0';

                printf("Enter your second number: ");
                if(fgets(num2, sizeof(num2), stdin)==NULL){
                    break;
                }
                num2[strcspn(num2, "\n")] = '\0';

                result = addstr(num1, num2);
                printf("Sum = %d\n\n", result);
                break;
            case 2:
                printf("Enter a string: ");
                if(fgets(buffer,sizeof(buffer), stdin)==NULL){
                    break;
                }
                result = is_palindromeASM(buffer);
                if(result) {
                    printf("It is a palindrome! \n\n");
                }
                else{
                    printf("It is NOT a palindrome! \n\n");
                }
                break;
            case 3:
                printf("Enter a number: ");
                if(fgets(buffer, sizeof(buffer), stdin)==NULL){
                    break;
                }
                buffer[strcspn(buffer, "\n")] = '\0';

                result = factstr(buffer);
                printf("Factorial = %d\n\n", result);
    
                break;
            case 4:
                palindrome_check();
                printf("\n");

                break;
            case 5:
                return 0;
                break;
            default:
                printf("You Entered an Invalid Choice. Please try again\n\n");
                break;
        }
    }
    return 0;
}


int is_palindromeC(char* s){
    int length = strlen(s);
    for(int i = 0; i<length/2; i++){
        if( s[i] != s[length-1-i]){
            return 0;
        }
    }
    return 1;
}

int fact(int n){
    if(n <= 1){
        return 1;

    }
    return n * fact(n-1);
}