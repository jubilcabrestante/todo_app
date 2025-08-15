// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
  id: json['id'] as String,
  productName: json['productName'] as String,
  cost: (json['cost'] as num).toInt(),
);

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'cost': instance.cost,
    };
