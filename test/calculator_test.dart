import 'package:flutter_test/flutter_test.dart';
import 'package:simplecalc/calculator.dart';

void main() {
  late Calculator calculator;
  setUp(() => calculator = Calculator());
  void enter(String value) {
    for (final digit in value.split('')) {
      calculator.digit(digit);
    }
  }

  test('basic arithmetic and decimal rounding', () {
    for (final example in [
      ['2', '+', '3', '5'],
      ['9', '-', '12', '-3'],
      ['6', '*', '7', '42'],
      ['9', '/', '4', '2.25'],
      ['0.1', '+', '0.2', '0.3'],
    ]) {
      calculator.clear();
      enter(example[0]);
      calculator.choose(example[1]);
      enter(example[2]);
      calculator.equals();
      expect(calculator.value, example[3]);
    }
  });

  test('operations chain from left to right', () {
    enter('2');
    calculator.choose('+');
    enter('3');
    calculator.choose('*');
    enter('4');
    calculator.equals();
    expect(calculator.value, '20');
  });

  test('operator can be replaced before the next operand', () {
    enter('9');
    calculator.choose('+');
    calculator.choose('-');
    enter('2');
    calculator.equals();
    expect(calculator.value, '7');
  });

  test('division by zero is recoverable with a new number', () {
    enter('8');
    calculator.choose('/');
    enter('0');
    calculator.equals();
    expect(calculator.value, 'Error');
    expect(calculator.expression, 'Cannot divide by zero');
    enter('4');
    expect(calculator.value, '4');
    expect(calculator.expression, isEmpty);
  });

  test('editing, duplicate decimals, and clear', () {
    enter('1.2.3');
    expect(calculator.value, '1.23');
    calculator.backspace();
    expect(calculator.value, '1.2');
    calculator.sign();
    expect(calculator.value, '-1.2');
    calculator.clear();
    expect(calculator.value, '0');
    expect(calculator.operator, isNull);
  });

  test('negative operands including negative fractions', () {
    enter('2');
    calculator.choose('*');
    calculator.sign();
    enter('.5');
    calculator.equals();
    expect(calculator.value, '-1');
    calculator.clear();
    calculator.sign();
    enter('5');
    expect(calculator.value, '-5');
  });

  test('typing after equals starts a new calculation', () {
    enter('4');
    calculator.choose('+');
    enter('3');
    calculator.equals();
    enter('2');
    expect(calculator.value, '2');
    expect(calculator.expression, isEmpty);
  });
}
