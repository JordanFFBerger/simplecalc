import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplecalc/main.dart';

void main() {
  testWidgets('touch controls calculate and clear', (tester) async {
    await tester.pumpWidget(const SimpleCalculatorApp());
    for (final key in ['7', '+', '3', '=']) {
      final button = find.widgetWithText(FilledButton, key);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
    }
    expect(tester.widget<Text>(find.byKey(const Key('result'))).data, '10');
    await tester.tap(find.widgetWithText(FilledButton, 'AC'));
    await tester.pump();
    expect(tester.widget<Text>(find.byKey(const Key('result'))).data, '0');
  });

  testWidgets('small and landscape screens remain usable', (tester) async {
    for (final size in [const Size(320, 568), const Size(640, 320)]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(const SimpleCalculatorApp());
      final equals = find.widgetWithText(FilledButton, '=');
      await tester.ensureVisible(equals);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(equals, findsOneWidget);
    }
    await tester.binding.setSurfaceSize(null);
  });
}
