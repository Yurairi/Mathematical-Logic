1. Создание древа семьи

    - С помощью базового  набора фактов  определить элементарные предикаты«родитель», «мужчина», «женщина»,
    задающие генеалогическое древо своей (или иной –возможно, вымышленной) семьи.

    - Задать правила – новые предикаты –как условия вывода новой связи (отношения) из уже
    имеющихся предикатов(которые заданы с помощью фактов или иных правил),описывающие конкретные родственные отношения,
    например,«мать», «сын», «брат», «тётя», «дед» и т.д.

    - К  созданной  базе  фактов  и  правил  составить  цели  различных  типов
    (задать разнотипные вопросы), например: 

    −односложные постоянные либо с неопределёнными (анонимными) переменными–вопрос типа «Да/Нет»;

    −односложные с переменными –для определения подходящих значений;

    −сложные –составленные с использованием логических связок  («not()» –отрицание,  «,» –конъюнкция, «;» –дизъюнкция);

    −с  выводом  дополнительных  текстовых  сообщений  (стандартныепредикатыwrite()или writeln()).
  
  2. Для заданныхзначения переменной x и количества слагаемых ряда n вычислить по приведённой приближённой формуле значение указанной функциии
      путём сравнения с точным значением функции (левой  части,  вычисляемой с помощью  стандартной  функции/предиката/оператора языка)
      найти абсолютную погрешность вычислений. Вывод данных выполнить в ясной для пользователя форме – например, в формате:
    
    StdSin(...) = ...
    ApproxSin(...) = ...
    (n= ...)
    AbsError= ...
    
    
      Вывод числовых значений выполнять с достаточной(единой, фиксированной) точностью
      (не менее 6 знаков после запятой). Для этого использовать, например, форматированный вывод данных 
      (стандартный  предикат writef() или format()см. раздел FormattedWriteв руководстве по SWIProlog).

      Функция в программе: sh(x) 

    
    3. Разработать Пролог-программу, организующую взаимодействие с пользователеми его доступ к основному функционалув формате диалога через консоль 
      с циклическим выполнением следующих действий: 

      •вывод информации о доступных командах и выполняемых в соответствии с ними действиях
      (одна из команд обязательно –для завершения работы программы);

      •считываниевводимой пользователем команды;

      •выполнение действия в соответствии свведённой пользователемкомандой.
    
    

    
    
    
    
