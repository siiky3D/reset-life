import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:reset_life/src/features/record_relapse/domain/relapse.dart';
import 'package:reset_life/src/features/statistics/domain/item.dart';

/// Model class representing the shopping cart contents.
class Calendar extends Equatable {
  const Calendar([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<RelapseID, int> items;

  // data serialization
  factory Calendar.fromMap(Map<String, dynamic> map) {
    return Calendar(
      Map<RelapseID, int>.from(map['items']),
    );
  }

  Map<String, dynamic> toMap() => {
        'items': items,
      };

  factory Calendar.fromJson(String source) => Calendar.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}

extension CartItems on Calendar {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(
        productId: entry.key,
        quantity: entry.value,
      );
    }).toList();
  }
}
