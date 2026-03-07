import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stockholm/stockholm.dart';

Widget _buildTestApp(Widget child) {
  return MaterialApp(
    theme: StockholmThemeData.light(),
    home: Scaffold(body: child),
  );
}

void main() {
  group('StockholmListTile', () {
    testWidgets(
      'Given a tile with onPressed when tapped then the callback is invoked',
      (tester) async {
        var pressed = false;

        await tester.pumpWidget(_buildTestApp(
          StockholmListTile(
            onPressed: () => pressed = true,
            child: const Text('Item'),
          ),
        ));

        await tester.tap(find.text('Item'));

        expect(pressed, isTrue);
      },
    );

    testWidgets(
      'Given a tile without onPressed when tapped then no error occurs',
      (tester) async {
        await tester.pumpWidget(_buildTestApp(
          const StockholmListTile(child: Text('Item')),
        ));

        await tester.tap(find.text('Item'));

        // No exception thrown — test passes implicitly
      },
    );
  });

  group('StockholmSideBar onDestinationSelected', () {
    testWidgets(
      'Given a sidebar with onDestinationSelected when first child is tapped then callback receives index 0',
      (tester) async {
        int? selectedIndex;

        await tester.pumpWidget(_buildTestApp(
          StockholmSideBar(
            onDestinationSelected: (index) => selectedIndex = index,
            children: const [
              StockholmListTile(child: Text('First')),
              StockholmListTile(child: Text('Second')),
            ],
          ),
        ));

        await tester.tap(find.text('First'));

        expect(selectedIndex, 0);
      },
    );

    testWidgets(
      'Given a sidebar with onDestinationSelected when second child is tapped then callback receives index 1',
      (tester) async {
        int? selectedIndex;

        await tester.pumpWidget(_buildTestApp(
          StockholmSideBar(
            onDestinationSelected: (index) => selectedIndex = index,
            children: const [
              StockholmListTile(child: Text('First')),
              StockholmListTile(child: Text('Second')),
            ],
          ),
        ));

        await tester.tap(find.text('Second'));

        expect(selectedIndex, 1);
      },
    );

    testWidgets(
      'Given a sidebar without onDestinationSelected when a child is tapped then no error occurs',
      (tester) async {
        await tester.pumpWidget(_buildTestApp(
          const StockholmSideBar(
            children: [
              StockholmListTile(child: Text('First')),
            ],
          ),
        ));

        await tester.tap(find.text('First'));

        // No exception thrown — test passes implicitly
      },
    );

    testWidgets(
      'Given a sidebar with onDestinationSelected and tiles with onPressed when a tile is tapped then both callbacks are invoked',
      (tester) async {
        int? destinationIndex;
        var tilePressed = false;

        await tester.pumpWidget(_buildTestApp(
          StockholmSideBar(
            onDestinationSelected: (index) => destinationIndex = index,
            children: [
              StockholmListTile(
                onPressed: () => tilePressed = true,
                child: const Text('Item'),
              ),
            ],
          ),
        ));

        await tester.tap(find.text('Item'));

        expect(destinationIndex, 0);
        expect(tilePressed, isTrue);
      },
    );

    testWidgets(
      'Given a sidebar with onDestinationSelected when tapping different children then callback always receives correct index',
      (tester) async {
        final tappedIndices = <int>[];

        await tester.pumpWidget(_buildTestApp(
          StockholmSideBar(
            onDestinationSelected: tappedIndices.add,
            children: const [
              StockholmListTile(child: Text('First')),
              StockholmListTile(child: Text('Second')),
              StockholmListTile(child: Text('Third')),
            ],
          ),
        ));

        await tester.tap(find.text('Third'));
        await tester.tap(find.text('First'));
        await tester.tap(find.text('Second'));

        expect(tappedIndices, [2, 0, 1]);
      },
    );
  });
}
