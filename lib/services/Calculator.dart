import 'dart:math';

class Calculator {
  RegExp _validExp;
  RegExp _math;
  RegExp _power;

  Calculator() {
    _validExp = new RegExp(
      r"^(\(*[0-9]+\!?\%?\)*|\(*[0-9]+\!?\%?\)*[\+\*-/^][0-9]+\!?\%?)([\+\*-/^]\(*[0-9]+\!?\%?\)*)*$",
    );
    _math = new RegExp(r"(sin|cos|tan|log|ln|inv|sqrt)\(.+\)");
    _power = new RegExp(r"\d+\^\d+");
  }

  bool _isNumeric(String number) {
    return number != null && double.parse(number, (e) => null) != null;
  }

  double _factorial(double num) {
    double result = 1;
    for (var i = 2; i <= num; i++) result *= i;
    return result;
  }

  String _solvePower(String exp) {
    Iterable<RegExpMatch> matches = _power.allMatches(exp);
    String expr;
    double num1, num2;
    Iterable<RegExpMatch> numMatches;
    RegExp numbers = new RegExp(r"\d+");
    matches.forEach((match) {
      expr = exp.substring(match.start, match.end);
      numMatches = numbers.allMatches(expr);
      num1 = double.parse(expr.substring(
          numMatches.elementAt(0).start, numMatches.elementAt(0).end));
      num2 = double.parse(expr.substring(
          numMatches.elementAt(1).start, numMatches.elementAt(1).end));
      num1 = pow(num1, num2);
      exp = exp.replaceFirst(expr, num1.toString());
    });
    return exp;
  }

  double _evaluate(List<String> exp) {
    List<double> operands = [];
    bool isDecimal = false;
    int decimal = 1;
    double result = 0.0;
    double number = 0.0;
    double temp;
    String sign = "+";
    String char;

    while (exp.length > 0) {
      char = exp.elementAt(0);
      if (char == '.') {
        isDecimal = true;
        decimal = 10;
        exp.removeAt(0);
        continue;
      } else if (char == '(') {
        exp.removeAt(0);
        number = _evaluate(exp);
      } else if (char == '!') {
        number = _factorial(number);
      } else if (char == '%') {
        if (operands.length > 0) {
          temp = operands.last;
          number = number * (temp / 100);
        } else
          number /= 100;
      } else if (_isNumeric(char)) {
        temp = double.parse(char);
        if (isDecimal) {
          temp /= decimal;
          decimal *= 10;
          number += temp;
        } else
          number = number * 10 + temp;
      }
      if (!_isNumeric(char) || exp.length == 1) {
        if (sign == '+') {
          operands.add(number);
        } else if (sign == '-') {
          operands.add(-number);
        } else if (sign == '*') {
          double temp = operands.last;
          operands.removeLast();
          operands.add(temp * number);
        } else if (sign == '/') {
          double temp = operands.last;
          operands.removeLast();
          operands.add(temp / number);
        }
        number = 0;
        isDecimal = false;
        decimal = 1;
        sign = char;
      }
      if (char == ')') break;
      if (exp.length > 0) exp.removeAt(0);
    }

    for (var number in operands) {
      result += number;
    }
    return result;
  }

  String _solveMath(String exp) {
    String expr;
    String subExp;
    double partResult;
    Iterable<RegExpMatch> matches = _math.allMatches(exp);
    if (matches.length == 0) return exp;
    matches.forEach((match) {
      expr = exp.substring(match.start, match.end);
      switch (expr.substring(0, 2)) {
        case "si":
          subExp = expr.substring(4, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = sin(partResult * (pi / 180));
          break;
        case "co":
          subExp = expr.substring(4, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = cos(partResult * (pi / 180));
          break;
        case "ta":
          subExp = expr.substring(4, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = tan(partResult * (pi / 180));
          break;
        case "lo":
          subExp = expr.substring(4, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = log(partResult) * log10e;
          break;
        case "ln":
          subExp = expr.substring(3, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = log(partResult);
          break;
        case "in":
          subExp = expr.substring(4, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = 1 / partResult;
          break;
        case "sq":
          subExp = expr.substring(5, expr.length - 1);
          partResult = _solveExp(subExp);
          partResult = sqrt(partResult);
          break;
      }
      exp = exp.replaceFirst(expr, partResult.toString());
    });
    return exp;
  }

  double _solveExp(String exp) {
    exp = _solveMath(exp);
    exp = _solvePower(exp);
    if (!_validExp.hasMatch(exp)) return null;
    return _evaluate(exp.split(""));
  }

  String solve(String exp) {
    exp = exp.replaceAll(new RegExp(r'x'), '*');
    exp = exp.replaceAll(new RegExp(r'÷'), '/');
    exp = exp.replaceAll(new RegExp(r'e'), e.toString());
    exp = exp.replaceAll(new RegExp(r'π'), pi.toString());
    double result = _solveExp(exp);
    if (result == null) return null;
    return result.toStringAsPrecision(5);
  }
}
