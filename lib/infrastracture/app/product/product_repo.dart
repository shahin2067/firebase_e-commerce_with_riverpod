import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/i_product_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/product_model.dart';

class ProductRepo extends IProductRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Either<CleanFailure, List<ProductModel>>> getProduct() async {
    try {
      final data = await db.collection("products").get().then((value) => value.docs.map((e) => ProductModel.fromMap(e.data())));

      Logger.i(data);

      return right(data.toList());
    } catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'Get Products'));
    }
  }
}
