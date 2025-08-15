import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_list.g.dart';

@JsonSerializable()
class ProductList {
  final String id;
  final String productName;
  final int cost;

  const ProductList({
    required this.id,
    required this.productName,
    required this.cost,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}
