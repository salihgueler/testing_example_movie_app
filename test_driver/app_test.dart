import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

main() {
  FlutterDriver _flutterDriver;

  setUp(() async {
    _flutterDriver = await FlutterDriver.connect();
  });

  tearDown(() {
    if (_flutterDriver != null) {
      _flutterDriver.close();
    }
  });

  group('MovieList', () {
    test('initialize', () async {
      await _flutterDriver.waitFor(find.byValueKey('movie-list'));
      final movieText = find.text('The Last Black Man in San Francisco');

      expect(
        await _flutterDriver.getText(movieText),
        'The Last Black Man in San Francisco',
        reason: 'Movie is not found',
      );
    });

    test('item click', () async {
      await _flutterDriver.waitFor(find.byValueKey('movie-list'));
      final movieText = find.text('The Last Black Man in San Francisco');
      await _flutterDriver.tap(movieText);

      await _flutterDriver.waitFor(find.text('Remaining Money: 82.0'));

      await _flutterDriver.tap(movieText);
      await _flutterDriver.tap(movieText);
      await _flutterDriver.tap(movieText);
      await _flutterDriver.tap(movieText);
      await _flutterDriver.tap(movieText);

      await _flutterDriver.waitFor(
        find.text(
          'Your last purchase for The Last Black Man in San Francisco\nwas not successful.\n\nYour remaining cash is 10.0.\n\nPlease either try again after topping up your account or buy a movie in your price range.',
        ),
      );
    });
  });
}
