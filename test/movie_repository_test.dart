import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testing_example_movie_app/movie/data/movie.dart';
import 'package:testing_example_movie_app/movie/data/movie_repository.dart';
import 'package:testing_example_movie_app/movie/data/purchase_result.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  MovieRepository _movieRepository;
  MockMovieRepository _mockMovieRepository;

  setUp(() {
    _movieRepository = MovieRepository(totalMoney: 20);
    _mockMovieRepository = MockMovieRepository();
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

  test(
    'Fetching Movies mockito',
    () async {
      final movie = Movie(
        price: 24,
        title: 'The Last Dance',
      );
      when(_mockMovieRepository.buyTicket(movie)).thenReturn(
        PurchaseResult(
          result: true,
          remainingMoney: 14,
        ),
      );

      expect(_mockMovieRepository.buyTicket(movie), isNotNull);
      final result = _mockMovieRepository.buyTicket(movie);
      expect(result.result, isTrue);
      expect(result.remainingMoney, 14);
    },
  );

  tearDown(() {
    _movieRepository.close();
  });
}
