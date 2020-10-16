import 'package:test/test.dart';
import 'package:testing_example_movie_app/movie/data/movie.dart';
import 'package:testing_example_movie_app/movie/data/movie_repository.dart';

void main() {
  MovieRepository _movieRepository;
  setUp(() {
    _movieRepository = MovieRepository(totalMoney: 20);
  });

  group('Ticket buying operation', () {
    test('with enough balance', () {
      final purchaseResult = _movieRepository.buyTicket(
        Movie(
          title: 'Greatest Showman',
          price: 16,
        ),
      );

      expect(purchaseResult.result, isTrue);
      expect(purchaseResult.remainingMoney, 4);
    });

    test('with few balance', () {
      final purchaseResult = _movieRepository.buyTicket(
        Movie(
          title: 'Family Man',
          price: 24,
        ),
      );
      expect(purchaseResult.result, isFalse);
      expect(purchaseResult.remainingMoney, 20);
    });
  });

  test(
    'Fetching Movies',
    () async {
      expect(await _movieRepository.fetchMovies(), hasLength(5));
    },
  );

  tearDown(() {
    _movieRepository.close();
  });
}
