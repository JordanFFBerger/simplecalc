import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculator.dart';

void main() => runApp(const SimpleCalculatorApp());

const _ink = Color(0xFF253A34);
const _green = Color(0xFF2F5143);
const _muted = Color(0xFF798679);

class SimpleCalculatorApp extends StatelessWidget {
  const SimpleCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _green),
        scaffoldBackgroundColor: const Color(0xFFF5F3ED),
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _calculator = Calculator();

  void _press(String key) {
    setState(() {
      switch (key) {
        case 'AC':
          _calculator.clear();
        case '+/−':
          _calculator.sign();
        case '⌫':
          _calculator.backspace();
        case '=':
          _calculator.equals();
        case '+':
        case '-':
        case '*':
        case '/':
          _calculator.choose(key);
        default:
          _calculator.digit(key);
      }
    });
  }

  KeyEventResult _keyboard(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed ||
        HardwareKeyboard.instance.isAltPressed) {
      return KeyEventResult.ignored;
    }
    final logical = event.logicalKey;
    final character = event.character;
    if (logical == LogicalKeyboardKey.enter ||
        logical == LogicalKeyboardKey.numpadEnter) {
      _press('=');
    } else if (logical == LogicalKeyboardKey.escape) {
      _press('AC');
    } else if (logical == LogicalKeyboardKey.backspace) {
      _press('⌫');
    } else if (character != null &&
        RegExp(r'^[0-9.+*/=\-]$').hasMatch(character)) {
      _press(character);
    } else {
      return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  Widget _button(String key, {int flex = 1}) {
    final isOperator = ['+', '-', '*', '/'].contains(key);
    final isUtility = ['AC', '+/−', '⌫'].contains(key);
    final selected = isOperator && _calculator.operator == key;
    final background = key == '='
        ? _green
        : selected
            ? const Color(0xFFCBD9BB)
            : isOperator
                ? const Color(0xFFE4EBDC)
                : isUtility
                    ? const Color(0xFFE8ECE3)
                    : const Color(0xFFF5F5EF);
    final label = const {
          'AC': 'Clear all',
          '+/−': 'Change sign',
          '⌫': 'Delete last digit',
          '/': 'Divide',
          '*': 'Multiply',
          '-': 'Subtract',
          '+': 'Add',
          '=': 'Equals',
          '.': 'Decimal point',
        }[key] ??
        key;
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Semantics(
          label: label,
          button: true,
          selected: isOperator ? selected : null,
          excludeSemantics: true,
          child: SizedBox(
            height: 62,
            child: FilledButton(
              onPressed: () => _press(key),
              style: FilledButton.styleFrom(
                backgroundColor: background,
                foregroundColor: key == '=' ? Colors.white : _ink,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(fontSize: isUtility ? 18 : 25),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(Calculator.symbol(key)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Focus(
          autofocus: true,
          onKeyEvent: _keyboard,
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48 > 0
                        ? constraints.maxHeight - 48
                        : 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: _green,
                            borderRadius: BorderRadius.circular(9)),
                        alignment: Alignment.center,
                        child: const Text('=',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                      const SizedBox(width: 10),
                      const Text('simple.',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: _ink)),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Column(children: [
                            const Text('A LITTLE LESS COMPLICATED',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w700,
                                    color: _muted)),
                            const SizedBox(height: 12),
                            const Text('Just the basics.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 36,
                                    letterSpacing: -1.5,
                                    color: _ink)),
                            const SizedBox(height: 8),
                            const Text('For the everyday things that add up.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: _muted)),
                            const SizedBox(height: 28),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCFCF8),
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(color: Colors.white),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x18304332),
                                    blurRadius: 36,
                                    offset: Offset(0, 14),
                                  )
                                ],
                              ),
                              child: Column(children: [
                                Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 13),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDF0E7),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          _calculator.expression.isEmpty
                                              ? ' '
                                              : _calculator.expression,
                                          key: const Key('expression'),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 14, color: _muted)),
                                      const SizedBox(height: 10),
                                      Semantics(
                                        liveRegion: true,
                                        label: 'Result: ${_calculator.value}',
                                        excludeSemantics: true,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(_calculator.value,
                                              key: const Key('result'),
                                              style: const TextStyle(
                                                  fontSize: 46,
                                                  color: _ink,
                                                  letterSpacing: -1)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                for (final row in [
                                  ['AC', '+/−', '⌫', '/'],
                                  ['7', '8', '9', '*'],
                                  ['4', '5', '6', '-'],
                                  ['1', '2', '3', '+'],
                                  ['0', '.', '='],
                                ])
                                  Row(children: [
                                    for (final key in row)
                                      _button(key, flex: key == '0' ? 2 : 1)
                                  ]),
                              ]),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    const Text('Small calculations. Clear answers.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: _muted)),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
