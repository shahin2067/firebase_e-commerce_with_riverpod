// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/product_model.dart';

class ProductState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<ProductModel> products;
  const ProductState({
    required this.loading,
    required this.failure,
    required this.products,
  });

  ProductState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<ProductModel>? products,
  }) {
    return ProductState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      products: products ?? this.products,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, products];

  factory ProductState.init() => ProductState(
      loading: false,
      failure: CleanFailure.none(),
      products: [ProductModel.init()]);
}
