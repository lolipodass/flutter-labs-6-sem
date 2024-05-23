import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/drag_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Drag widget test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(
      MaterialApp(
        home: DragWidgetPage(),
      ),
    );

    // Find the draggable widget
    final draggableWidget = find.byType(Draggable);

    // Verify the widget is present
    expect(draggableWidget, findsOneWidget);

    // Drag the widget to a new position
    final targetPosition = const Offset(200.0, 300.0);
    await tester.drag(draggableWidget, targetPosition);
    await tester.pumpAndSettle();

    // Verify the widget's position has updated
    final widgetFinder = find.byType(Positioned);
    expect(widgetFinder, findsOneWidget);
    final positionedWidget = tester.widget<Positioned>(widgetFinder);
    expect(positionedWidget.left, targetPosition.dx);
    expect(positionedWidget.top, targetPosition.dy + 56.0);
  });
}


// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_application_1/auth/home.dart';

// void main() {
//   testWidgets('Drag game card', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: MyHomePage()));

//     final textFieldFinder = find.byKey(const Key("addField"));
//     await tester.enterText(textFieldFinder, 'Test Games');
//     await tester.tap(find.byKey(const Key("addButton")));
//     await tester.pumpAndSettle();

//     final draggableFinder = find.byType(Draggable);
//     await tester.drag(draggableFinder, const Offset(0, 100));
//     await tester.pumpAndSettle();

//     expect(find.text('Test Games'), findsOneWidget);
//   });
// }
