import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_example_movie_app/main.dart';
import 'package:testing_example_movie_app/movie/data/movie.dart';
import 'package:testing_example_movie_app/movie/data/movie_repository.dart';

main() {
  MovieRepository _movieRepository;

  setUp(() {
    _movieRepository = MovieRepository(totalMoney: 20);
  });

  group('Movie List rendering', () {
    testWidgets('with type', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieList(
              const <Movie>[
                Movie(
                  title: 'Bye Bye Lenin!',
                  price: 16.0,
                ),
                Movie(
                  title: 'Avengers:Endgame',
                  price: 25.0,
                ),
              ],
              (movie) => _movieRepository.buyTicket(movie),
            ),
          ),
        ),
      );

      expect(
        find.byType(ListTile),
        findsNWidgets(2),
        reason: 'There must be 2 ListTiles showing the movies',
      );
    });

    testWidgets('with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieList(
              const <Movie>[
                Movie(
                  title: 'Bye Bye Lenin!',
                  price: 16.0,
                ),
                Movie(
                  title: 'Avengers:Endgame',
                  price: 25.0,
                ),
              ],
              (movie) => _movieRepository.buyTicket(movie),
            ),
          ),
        ),
      );

      final titleFinder = find.text('Bye Bye Lenin!');
      final messageFinder = find.text('Avengers:Endgame');

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
    });

    testWidgets('with key', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieList(
              const <Movie>[
                Movie(
                  title: 'Bye Bye Lenin!',
                  price: 16.0,
                ),
                Movie(
                  title: 'Avengers:Endgame',
                  price: 25.0,
                ),
              ],
              (movie) => _movieRepository.buyTicket(movie),
            ),
          ),
        ),
      );

      final titleFinder = find.byKey(Key('Bye Bye Lenin!'));
      final messageFinder = find.byKey(Key('Avengers:Endgame'));

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
    });
  });

  tearDown(() {
    _movieRepository.close();
  });
}
