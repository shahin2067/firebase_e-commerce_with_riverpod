import 'package:clean_api/clean_api.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/product_model.dart';

abstract class IProductRepo {
  Future<Either<CleanFailure, ProductModel>> getProduct();
}
