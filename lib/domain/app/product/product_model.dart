import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String productDes;
  final List<dynamic> productImg;
  final String productPrice;
  final String productName;
  const ProductModel({
    required this.productDes,
    required this.productImg,
    required this.productPrice,
    required this.productName,
  });

  ProductModel copyWith({
    String? productDes,
    List<dynamic>? productImg,
    String? productPrice,
    String? productName,
  }) {
    return ProductModel(
      productDes: productDes ?? this.productDes,
      productImg: productImg ?? this.productImg,
      productPrice: productPrice ?? this.productPrice,
      productName: productName ?? this.productName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product-description': productDes,
      'product-img': productImg,
      'product-price': productPrice,
      'product-name': productName,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productDes: map['product-description'] as String,
      productImg: List<dynamic>.from((map['product-img'] as List<dynamic>)),
      productPrice: map['product-price'] as String,
      productName: map['product-name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [productDes, productImg, productPrice, productName];

  factory ProductModel.init() => const ProductModel(
      productDes: '', productImg: [], productPrice: '', productName: '');
}
