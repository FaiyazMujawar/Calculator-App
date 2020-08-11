class Calculator {
  RegExp mathExp;

  Calculator() {
    /*
      RegEx to check if mathematical expression is valid. Basic only, 
      without brackets.
    */
    mathExp = new RegExp(
      r"^([0-9]+\%?\!?|[0-9]+\!?[\+\*-/^][0-9]+\%?\!?)([\+\*-/^][0-9]+\%?\!?)*$",
    );
  }

  String solveExp(String exp) {
    exp = exp.replaceAll(new RegExp(r'x'), '*');
    exp = exp.replaceAll(new RegExp(r'÷'), '/');
    if (!mathExp.hasMatch(exp)) return null;
    int length = exp.length;
    List<double> operands = [];
    double result = 0;
    double number = 0;
    String sign = "+";
    String num = "";
    for (int i = 0; i < length; i++) {
      num = exp[i];
      if (num == " ") continue;
      if (_isNumeric(num)) {
        number = number * 10 + double.parse(num);
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
        } else if (sign == "!") {
          double n = operands.last;
          operands.removeLast();
          operands.add(_factorial(n));
        } else if (sign == "%") {
          if (operands.length > 0) {
            double n = operands.last;
            operands.add((number * n) / 100.0);
          } else {
            operands.add(number / 100);
          }
        }
        exp.replaceFirst(new RegExp(r'num'), " ");
        number = 0;
        sign = num;
      }
    }
    for (var i = 0; i < operands.length; i++) {
      result += operands[i];
    }
    String res = result.toStringAsFixed(4);
    res = res.replaceAll(new RegExp(r'\.0+$'), "");
    return res;
  }

  bool _isNumeric(String num) {
    return num == null ? false : double.parse(num, (e) => null) != null;
  }

  double _factorial(double num) {
    double result;
    for (var i = 1; i <= num; i++) result *= i;
    return result;
  }
}
