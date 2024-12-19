import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../tester_extensions.dart';

void main() {
  testWidgets('SizeEffect: size', (tester) async {
    final animation = const FlutterLogo().animate().size(
          duration: 1000.ms,
          begin: 1.0,
          end: 0.0,
        );

    await tester.pumpAnimation(MaterialApp(home: animation),
        initialDelay: 500.ms);
    _verifySize(tester, 0.5, 0.5);
  });

  testWidgets('SizeEffect: size', (tester) async {
    final animation =
        const FlutterLogo().animate().size(duration: 1000.ms, end: 2);

    // Check halfway,
    await tester.pumpAnimation(MaterialApp(home: animation),
        initialDelay: 500.ms);
    _verifySize(tester, 1.5, 1.5);
  });

  testWidgets('SizeEffect: sizeX', (tester) async {
    final animation =
        const FlutterLogo().animate().sizeX(duration: 1000.ms, end: 2);

    // Check halfway,
    await tester.pumpAnimation(MaterialApp(home: animation),
        initialDelay: 500.ms);
    _verifySize(tester, 1.5, 1);
  });

  testWidgets('SizeEffect: sizeY', (tester) async {
    final animation =
        const FlutterLogo().animate().sizeY(duration: 1000.ms, end: 2);

    // Check halfway,
    await tester.pumpAnimation(MaterialApp(home: animation),
        initialDelay: 500.ms);
    _verifySize(tester, 1, 1.5);
  });
}

_verifySize(
    WidgetTester tester, double widthFactor, double heightFactor) async {
  tester.widget(find.byType(Align));
  expect(
      tester.widget(find.byType(Align)),
      isA<Align>()
          .having(
              (Align align) => align.widthFactor, 'widthFactor', widthFactor)
          .having((Align align) => align.heightFactor, 'heightFactor',
              heightFactor));
}
