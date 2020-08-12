import 'dart:math';

class Calculator {
  RegExp mathExp;
  RegExp math;

  Calculator() {
    /*
      RegEx to check if mathematical expression is valid. Basic only, 
      without brackets.
    */
    mathExp = new RegExp(
      /* r"^([0-9]+\%?\!?|[0-9]+\!?[\+\*-/^][0-9]+\%?\!?)([\+\*-/^][0-9]+\%?\!?)*$", */
      r"^(\(?[0-9]+\)?\!?\%?\)?|\(?[0-9]+?\!?\)?[\+\*-/^]\(?[0-9]+?\!?\%?\)?)([\+\*-/^]\(?[0-9]+\)?\!?\%?\)?)*$",
    );

    math = new RegExp(r"(sin|cos|tan|log|ln|sqrt|inv)\(.+\)");
  }

  double _solveExp(String exp) {
    int length = exp.length;
    int decimal = 1;
    bool isDecimal = false;
    List<double> operands = [];
    double temp;
    double result = 0;
    double number = 0;
    String sign = "+";
    String num = "";
    for (int i = 0; i < length; i++) {
      num = exp[i];
      if (num == " ") continue;
      exp = exp.replaceFirst(num, " ");
      if (_isNumeric(num)) {
        temp = double.parse(num);
        if (isDecimal) {
          temp = temp / decimal;
          decimal *= 10;
          number += temp;
        } else
          number = number * 10 + temp;
      }
      if (num == ".") {
        decimal = 10;
        isDecimal = true;
        continue;
      }
      if (num == "!") {
        number = _factorial(number);
      }

      if (!_isNumeric(num) || i == length - 1) {
        if (sign == "+")
          operands.add(number);
        else if (sign == "-")
          operands.add(-number);
        else if (sign == "*") {
          double n = operands.last;
          operands.removeLast();
          operands.add(n * number);
        } else if (sign == "/") {
          double n = operands.last;
          operands.removeLast();
          operands.add(n / number);
        } else if (sign == "%") {
          print(number);
          operands.add(number / 100);
        } else if (sign == "^") {
          double n = operands.last;
          operands.removeLast();
          operands.add(pow(n, number));
        }
        number = 0;
        sign = num;
        isDecimal = false;
        decimal = 1;
      }
    }
    for (var i = 0; i < operands.length; i++) {
      result += operands[i];
    }
    return result;
  }

  double _evaluate(String exp) {
    exp = _solveMath(exp);
    if (!mathExp.hasMatch(exp)) return null;
    return _solveExp(exp);
  }

  String calculate(String exp) {
    double result = _evaluate(exp);
    if (result == null) return null;
    String res = result.toStringAsFixed(4);
    res = res.replaceAll(new RegExp(r'\.0+$'), "");
    return res;
  }

  String _solveMath(String exp) {
    String subExp;
    String expr;
    double partResult;
    Iterable<RegExpMatch> matches = math.allMatches(exp);
    matches.forEach(
      (match) {
        expr = exp.substring(match.start, match.end);
        switch (exp.substring(match.start, match.start + 2)) {
          // Evaluating "sin"
          case "si":
            subExp = exp.substring(match.start + 4, match.end - 1);
            partResult = _evaluate(subExp);
            print(partResult);
            partResult = sin((partResult * pi) / 180);
            print(partResult);
            break;
          // Evaluating "cos"
          case "co":
            subExp = exp.substring(match.start + 4, match.end - 1);
            partResult = _evaluate(subExp);
            partResult = cos((partResult * pi) / 180);
            break;
          // Evaluating "tan"
          case "ta":
            subExp = exp.substring(match.start + 4, match.end - 1);
            partResult = _evaluate(subExp);
            partResult = tan((partResult * pi) / 180);
            break;
          // Evaluating "log"
          case "lo":
            subExp = exp.substring(match.start + 4, match.end - 1);
            partResult = _evaluate(subExp);
            partResult = log(partResult) * log10e;
            break;
          // Evaluating "ln"
          case "ln":
            subExp = exp.substring(match.start + 3, match.end - 1);
            partResult = _evaluate(subExp);
            partResult = log(partResult);
            break;
          // Evaluating "sqrt"
          case "sq":
            subExp = exp.substring(match.start + 5, match.end - 1);
            partResult = _evaluate(subExp);
            partResult = sqrt(partResult);
            break;
          // Evaluating "inv"
          case "in":
            subExp = exp.substring(match.start + 4, match.end - 1);
            partResult = _evaluate(subExp);
            partResult = 1 / partResult;
            break;
        }
        exp = exp.replaceAll(expr, partResult.toString());
      },
    );
    return exp;
  }
}

bool _isNumeric(String num) {
  return num == null ? false : double.parse(num, (e) => null) != null;
}

double _factorial(double num) {
  double result = 1;
  for (var i = 1; i <= num; i++) result *= i;
  return result;
}
