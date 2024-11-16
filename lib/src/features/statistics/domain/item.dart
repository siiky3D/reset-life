import 'package:equatable/equatable.dart';
import 'package:reset_life/src/features/record_relapse/domain/relapse.dart';

/// A product along with a quantity that can be added to an order/cart
class Item extends Equatable {
  const Item({
    required this.productId,
    required this.quantity,
  });
  final RelapseID productId;
  final int quantity;

  @override
  List<Object?> get props => [productId, quantity];

  @override
  bool? get stringify => true;
}
