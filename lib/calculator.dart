/// Basic calculator with immediate, left-to-right operation chaining.
class Calculator {
  String value = '0';
  String expression = '';
  String? operator;
  double? _previous;
  bool _fresh = true;

  void clear() {
    value = '0';
    expression = '';
    operator = null;
    _previous = null;
    _fresh = true;
  }

  void digit(String digit) {
    if (!RegExp(r'^[0-9.]$').hasMatch(digit)) return;
    if (value == 'Error') clear();
    if (_fresh) {
      value = digit == '.' ? '0.' : digit;
      _fresh = false;
      if (operator == null) expression = '';
      return;
    }
    if (digit == '.' && value.contains('.')) return;
    if (value.replaceAll(RegExp(r'[-.]'), '').length >= 12) return;
    if (digit != '.' && (value == '0' || value == '-0')) {
      value = value.startsWith('-') ? '-$digit' : digit;
    } else {
      value += digit;
    }
  }

  static String symbol(String op) =>
      const {'+': '+', '-': '−', '*': '×', '/': '÷'}[op] ?? op;

  void choose(String op) {
    if (!['+', '-', '*', '/'].contains(op) || value == 'Error') return;
    if (operator != null && !_fresh) equals();
    if (value == 'Error') return;
    _previous = double.parse(value);
    operator = op;
    _fresh = true;
    expression = '$value ${symbol(op)}';
  }

  void equals() {
    final op = operator;
    final a = _previous;
    if (op == null || a == null || value == 'Error') return;
    final b = double.parse(value);
    expression = '${_format(a)} ${symbol(op)} $value =';
    final result = switch (op) {
      '+' => a + b,
      '-' => a - b,
      '*' => a * b,
      '/' => b == 0 ? double.nan : a / b,
      _ => double.nan,
    };
    value = result.isFinite ? _format(result) : 'Error';
    if (!result.isFinite) {
      expression =
          op == '/' && b == 0 ? 'Cannot divide by zero' : 'Result is too large';
    }
    operator = null;
    _previous = null;
    _fresh = true;
  }

  void sign() {
    if (value == 'Error') return;
    // After an operator, +/- starts a negative operand, including -0.5.
    if (_fresh && operator != null) {
      value = '-0';
    } else {
      value = value.startsWith('-') ? value.substring(1) : '-$value';
    }
    _fresh = false;
    if (operator == null) expression = '';
  }

  void backspace() {
    if (value == 'Error') {
      clear();
      return;
    }
    if (_fresh) return;
    // A computed scientific-notation result is not editable digit-by-digit.
    if (value.contains('e')) {
      value = '0';
      return;
    }
    value = value.substring(0, value.length - 1);
    if (value.isEmpty || value == '-') value = '0';
  }

  static String _format(double number) {
    if (number == 0) return '0';
    final rounded = double.parse(number.toStringAsPrecision(12));
    return rounded.toString().replaceFirst(RegExp(r'\.0(?=e|$)'), '');
  }
}
