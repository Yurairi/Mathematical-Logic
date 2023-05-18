#pragma once
#include <iostream>
#include <stdlib.h>
#include <algorithm> 
#include <string>


#define MAX_stack 100

bool Full();
bool Empty();
void Push_digit(int value);
void Push_oper(char value);
int Pop_digit();
char Pop_char();
bool IsOp(char c);
void free_param();
void oper();
int RPN(std::string expression, int x, int y);
int input_for_menu(int stat);
void menu();