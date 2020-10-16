import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

class PurchaseResult extends Equatable {
  final bool result;
  final double remainingMoney;

  const PurchaseResult({
    @required this.result,
    @required this.remainingMoney,
  })  : assert(result != null),
        assert(remainingMoney != null);

  @override
  List<Object> get props => [result, remainingMoney];

  @override
  bool get stringify => true;
}
