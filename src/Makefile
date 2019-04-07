
YACC = yacc 



logicCalculator: logic_calc.c
	gcc -Wall logic_calc.c

logic_calc.c: logic_calc.y
	$(YACC) logic_calc.y -o logic_calc.c


