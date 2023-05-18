#include"RPN.h"


namespace imp_numb {
	int k;
	int n;
}
using imp_numb::k;
using imp_numb::n;


namespace parameters {
	int _stack[MAX_stack]{ 0 };
	char _stack_2[MAX_stack]{ '\0' };
	int tos = 0;
	int tos_2 = 0;
}


bool Full() {
	return parameters::tos >= MAX_stack - 1;
}

bool Empty() {
	return parameters::tos == 0;
}

void Push_digit(int value) {
	if (!Full()) {
		parameters::_stack[parameters::tos] = value;
		parameters::tos++;
	}
}

void Push_oper(char value) {
	if (!Full()) {
		parameters::_stack_2[parameters::tos_2] = value;
		parameters::tos_2++;
	}
}

int Pop_digit() {
	int t = parameters::_stack[parameters::tos - 1];
	parameters::tos--;
	return t;
}

char Pop_char() {
	char t = parameters::_stack_2[parameters::tos_2 - 1];
	parameters::tos_2--;
	return t;
}

bool IsOp(char c) {
	//Check for operators.
	switch (c) {
	case 'J':
	case 'v':
	case '(':
	case ')':
		return true;
	default:
		return false;
	}
}

void oper() {
	std::string operat = "";
	while (parameters::_stack_2[parameters::tos_2] != '(') {
		operat = operat + Pop_char();
	}
	//reverse(operat.begin(), operat.end());

	//std::cout << "oper" << operat << "\n";
	//for (int i = 0; i < parameters::tos; i++) std::cout << "  " << parameters::_stack[i];

	/*int j_c = 1;
	for (int j = 0; j < operat.length(); j++) {
		if (operat[j] == 'J') {
			std::cout << j << ". char = " << operat[j] << "used = " << parameters::_stack[j_c] << "\n";
			if (parameters::_stack[j - j_c] != 1) parameters::_stack[j - j_c] = 0;
			j_c++;
		}
	}*/
	int i = 0;
	while (i < operat.length()) {
		if (operat[i] == 'v') {
			int v_1 = Pop_digit();
			int v_2 = Pop_digit();
			if (operat[i + 1] == 'J') {
				//std::cout << "  " << v_2 << "\n";
				if (v_2 != 1) v_2 = 0;
				i++;
			}
			Push_digit(std::max(v_1, v_2));
		}
		else if (operat[i] == 'J') {
			//std::cout << "  " << parameters::_stack[parameters::tos - 1] << "\n";
			if (parameters::_stack[parameters::tos - 1] != 1) parameters::_stack[parameters::tos - 1] = 0;
		}
		i++;
	}
}

void free_param() {
	for (int i = 0; i < MAX_stack; i++) {
		parameters::_stack[i] = 0;
		parameters::_stack_2[i] = '\0';
	}
	parameters::tos = 0;
	parameters::tos_2 = 0;
}


int RPN(std::string exp, int x, int y) {
	int i = 0;
	int ret = -1;
	int fl_err = 1;
	int sc_count = 0;
	while (i < exp.length()) {
		if (isdigit(exp[i])) {
			std::string tok;
			while (isdigit(exp[i])) {
				tok += exp[i];
				i++;
			}
			//i--; ///////////
			if (atoi(tok.c_str()) > k - 1) { fl_err = 0; break; }
			else Push_digit(atoi(tok.c_str()));
		}
		else if (IsOp(exp[i])) Push_oper(exp[i]);
		else if (exp[i] == 'X' || exp[i] == 'x') Push_digit(x);
		else if (exp[i] == 'Y' || exp[i] == 'y') {
			if (n == 2) Push_digit(y);
			else { std::cout << "Invaild exp. \n";  fl_err = 0; break; }
		}
		else if (exp[i] != ' ') { std::cout << "Invaild exp. \n";  fl_err = 0; break; }

		//Operation 
		if (exp[i] == ')' || exp[i] == '(') sc_count++;
		if (exp[i] == ')' && i != exp.length() - 1) oper();
		i++;
	}
	if (sc_count % 2 == 1) fl_err = 0;

	if (fl_err) {
		oper();
		ret = parameters::_stack[0];
	}

	free_param();
	return ret;
}

void menu() {
	//Варианты
	std::cout << "В соответствии с вариантом задания: \n";
	std::cout << "Вариант для унарной операции: 5 - J(x) характеристическая функция второго рода числа i \n";
	std::cout << "Вариант для бинарной операции: 2 - x v y максимум (обобщение дизъюнкции)\n";
	std::cout << "Вариант для стандартной формы представления: 2 - вторая форма\n";

	while (true) {
		//Первый пункт - запрос у пользователя числа k (ограничение - < 100)
		std::cout << "\n\nВведите число k: \n";
		k = input_for_menu(3);


		//Второй пункт - запрос у пользователя существенных переменных (ограничение = 1 or 2)
		int* x = new int[k * k];
		int* y = new int[k * k];
		for (int i = 0; i < k * k; i++) {
			x[i] = 0;
			y[i] = 0;
		}
		std::cout << "Введите число n: \n";
		n = input_for_menu(2);

		if (n == 1) {
			for (int i = 0; i < k; i++) x[i] = i;
		}
		else {
			int co = 0, counter = 0;
			while (co != k) {
				for (int i = 0; i < k; i++) {
					x[counter] = co;
					counter++;
				}
				co++;
			}
			for (int i = 0; i < k * k; i++) {
				y[i] = i % k;
			}
		}


		//Третий пункт - ввод функции в аналитической форме
		std::string func;
		int fl_p_2 = -1; int fl_kk = 1;

		while (fl_p_2 == -1) {
			std::cout << " \nВведите аналитическую функцию: \n";
			std::cin.clear();
			std::getline(std::cin, func);
			if (fl_kk) { std::getline(std::cin, func); fl_kk = 0; }
			fl_p_2 = RPN(func, 0, 0);
			if (fl_p_2 == -1) std::cout << "Неверно введена строка. Повторите ввод. \n";
		}

		std::string head = "(";
		func = head + func + ")";

		std::cout << "\n";
		int* res = new int[k * k];

		std::cout << "\nЗначения функции: \n";

		if (n == 1) {
			for (int i = 0; i < k; i++) {
				res[i] = RPN(func, x[i], 0);
				std::cout << "   x = " << x[i] << "  f(x)" << res[i] << "\n";
			}
		}
		else {
			for (int i = 0; i < k * k; i++) {
				res[i] = RPN(func, x[i], y[i]);
				std::cout << "   x = " << x[i] << "   y = " << y[i] << "   f(x, y) = " << res[i] << "\n";
			}
		}


		//Четвертый пункт - составление второй формы
		std::cout << "\nВторая форма: \n";
		if (n == 1) {
			int fl_plus = 0;
			for (int i = 0; i < k; i++) {
				if (res[i] != 0) {
					if (fl_plus) std::cout << " + ";
					std::cout << res[i] << "j_" << i << "(x)";
					fl_plus = 1;
				}
			}
		}
		else {
			int fl_plus = 0;
			for (int i = 0; i < k * k; i++) {
				if (res[i] != 0) {
					if (fl_plus) std::cout << " + ";
					std::cout << res[i] << "j_" << x[i] << "(x)j_" << y[i] << "(y)";
					fl_plus = 1;
				}
			}
		}


		//Пятый пункт - проверка принадлежности функции классу
		int fl_p_3 = 1;
		while (fl_p_3) {
			std::cout << "\n\nЧисла во множестве не должны превышать заданное число k.\n";
			std::cout << "Введите множество через пробел \n";
			std::string digits;
			std::cin.clear();
			std::getline(std::cin, digits);

			int i = 0, cont = 0, fl_err_4 = 1;
			int* _set = new int[digits.length()];
			while (i < digits.length()) {
				if (!isdigit(digits[i])) {
					i++;
				}
				//Check for digits
				if (isdigit(digits[i])) {
					std::string tok;
					while (isdigit(digits[i])) {
						tok += digits[i];
						i++;
					}
					_set[cont] = atoi(tok.c_str());
					cont++;
				}
			}
			for (int i = 0; i < cont; i++) {
				if (_set[i] > k || _set[i] < 0) {
					std::cout << "Неверный ввод.\n";
					fl_err_4 = 0;
					break;
				}
			}

			
			if (n == 1 && fl_err_4 && cont) {
				int res_for_4 = 1;
				for (int ii = 0; ii < cont; ii++) {
					int dop_fl_4 = 1;
					for (int j = 0; j < cont; j++) {
						if (_set[j] == res[_set[ii]]) {
							dop_fl_4 = 0;
							break;
						}
					}
					if (dop_fl_4) {
						std::cout << "Классу не принадлежит.\n";
						fl_p_3 = 0;
						res_for_4 = 0;
						break;
					}
				}
				if (res_for_4) {
					fl_p_3 = 0; std::cout << "Классу принадлежит.\n";
				}
			}
			else if (n == 2 && fl_err_4 && cont) {
				int dop_fl_4_2 = 1;
				int res_for_4_2 = 1;
				for (int i = 0; i < k * k; i++) {
					int numb = 0, pr = 0;
					for (int j = 0; j < cont; j++) {
						if (x[i] == _set[j]) { numb = x[i] * k; pr += 1; }
						if (y[i] == _set[j]) { numb += y[i]; pr += 1; }
					}
					if (pr == 2) {
						for (int j = 0; j < cont; j++) {
							//std::cout << "x = " << x[i] << "  y = " << y[i] << " res = " << res[numb] << "\n";
							if (res[numb] == _set[j]) {
								dop_fl_4_2 = 0;
								break;
							}
						}
					}
					if (pr == 2 && dop_fl_4_2) {
						std::cout << "Классу не принадлежит.\n";
						res_for_4_2 = 0;
						fl_p_3 = 0;
						break;
					}
				}
				
				if (res_for_4_2) { std::cout << "Классу принадлежит.\n"; fl_p_3 = 0; }
			}
			if (!cont) std::cout << "Неверный ввод.\n";
			free(_set);
		}

		free(x);
		free(y);
		free(res);
	}
}



int input_for_menu(int stat) {
	int choice;
	while (!(std::cin >> choice))
	{
		std::cin.clear();
		while (std::cin.get() != '\n') {
			std::cout << "Повторите ввод : \n";
		}
	}
	if (stat == 1 && (choice > 5 || choice < 0)) {
		std::cout << "Повторите ввод : \n";
		choice = input_for_menu(1);
	}
	if (stat == 2 && choice != 1 && choice != 2) {
		std::cout << "Повторите ввод : \n";
		choice = input_for_menu(2);
	}
	if (stat == 3 && (choice <= 0 || choice > 100)) {
		std::cout << "Повторите ввод : \n";
		choice = input_for_menu(3);
	}
	return choice;
}