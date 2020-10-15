import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

class Movie extends Equatable {
  final String title;
  final double price;

  const Movie({
    @required this.title,
    @required this.price,
  })  : assert(title != null),
        assert(price != null);

  @override
  List<Object> get props => [title, price];

  @override
  bool get stringify => true;
}
