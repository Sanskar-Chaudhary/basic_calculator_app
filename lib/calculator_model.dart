class CalculatorModel {
  double calculate(String expression) {
    try {
      // Adjust for percentage usage in the expression
      expression = _convertPercentages(expression);
      // Parse and evaluate the expression as usual
      List<String> tokens = _tokenize(expression);
      List<String> postfix = _infixToPostfix(tokens);
      double result = _evaluatePostfix(postfix);
      return result;
    } catch (e) {
      print('Error evaluating expression: $e');
      return 0.0; // Return 0.0 on error
    }
  }

  String _convertPercentages(String expression) {
    // This regex looks for a pattern where a number is followed by % and then another number
    RegExp regex = RegExp(r'(\d+)%(\d+)');
    expression = expression.replaceAllMapped(regex, (Match m) {
      if (m.groupCount == 2) {
        var base = double.parse(m.group(1) ?? '0');  // The base value (100 in 100%50)
        var percent = double.parse(m.group(2) ?? '0');  // The percentage value (50 in 100%50)
        var result = (base * percent) / 100;  // Calculate the percentage of the base
        return result.toString();
      }
      return '';  // Fallback empty string if regex groups aren't found
    });

    // Handle simple percentage conversion if it's at the end of the expression
    regex = RegExp(r'(\d+)%');
    expression = expression.replaceAllMapped(regex, (Match m) {
      double num = double.parse(m.group(1) ?? '0');
      double decimal = num / 100;
      return decimal.toString();  // Convert to percentage
    });

    return expression;
  }



  List<String> _tokenize(String expression) {
    RegExp regex = RegExp(r'(\d+\.?\d*|[\+\-\*/])');
    return regex.allMatches(expression).map((m) => m.group(0)!).toList();
  }

  List<String> _infixToPostfix(List<String> tokens) {
    List<String> output = [];
    List<String> opsStack = [];
    Map<String, int> precedence = {'+': 1, '-': 1, '*': 2, '/': 2};

    for (var token in tokens) {
      if (double.tryParse(token) != null) {
        output.add(token);
      } else if (token == '*' || token == '/' || token == '+' || token == '-') {
        while (opsStack.isNotEmpty &&
            precedence[opsStack.last]! >= precedence[token]!) {
          output.add(opsStack.removeLast());
        }
        opsStack.add(token);
      }
    }

    while (opsStack.isNotEmpty) {
      output.add(opsStack.removeLast());
    }
    return output;
  }

  double _evaluatePostfix(List<String> postfix) {
    List<double> stack = [];
    for (var token in postfix) {
      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else {
        double num2 = stack.removeLast();
        double num1 = stack.removeLast();
        switch (token) {
          case '+':
            stack.add(num1 + num2);
            break;
          case '-':
            stack.add(num1 - num2);
            break;
          case '*':
            stack.add(num1 * num2);
            break;
          case '/':
            stack.add(num1 / num2);
            break;
        }
      }
    }
    return stack.first;
  }
}
