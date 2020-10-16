import 'dart:async';

import 'package:testing_example_movie_app/movie/data/movie.dart';
import 'package:testing_example_movie_app/movie/data/purchase_result.dart';

class MovieRepository {
  double _totalMoney;
  final _streamController = StreamController<double>();

  MovieRepository({
    double totalMoney = 100,
  })  : this._totalMoney = totalMoney,
        super() {
    _streamController.add(totalMoney);
  }

  Stream<double> get currentValue => _streamController.stream;

  Future<List<Movie>> fetchMovies() => Future<List<Movie>>.delayed(
        const Duration(
          seconds: 2,
        ),
        () => const <Movie>[
          Movie(
            title: 'Palm Springs',
            price: 16,
          ),
          Movie(
            title: 'Jojo Rabbit',
            price: 20,
          ),
          Movie(
            title: 'Waves',
            price: 14,
          ),
          Movie(
            title: 'The Last Black Man in San Francisco',
            price: 18,
          ),
          Movie(
            title: 'Hamilton',
            price: 32,
          ),
        ],
      );

  PurchaseResult buyTicket(Movie movie) {
    if (_totalMoney >= movie.price) {
      _totalMoney -= movie.price;
      _streamController.add(_totalMoney);
      return PurchaseResult(remainingMoney: _totalMoney, result: true);
    } else {
      return PurchaseResult(remainingMoney: _totalMoney, result: false);
    }
  }

  void close() {
    _streamController.close();
  }
}
