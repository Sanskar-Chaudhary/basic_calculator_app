import 'calculator_model.dart';

class CalculatorController {
  final CalculatorModel model = CalculatorModel();
  String displayText = '0';

  void inputCharacter(String char) {
    if (displayText == '0' && char != 'AC' && char != '=' && char != '%') {
      displayText = '';
    }

    switch (char) {
      case 'AC':
        displayText = '0';
        break;
      case '=':
        displayText = model.calculate(displayText).toString();
        break;
      case '%':
        if (displayText.isNotEmpty) {
          displayText += '%';
        }
        break;
      default:
        displayText += char;
        break;
    }
  }
}
