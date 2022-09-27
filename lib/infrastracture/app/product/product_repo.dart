// import 'package:clean_api/clean_api.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/i_product_repo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/product_model.dart';

// class ProducRepo extends IProductRepo {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   Future<Either<CleanFailure, ProductModel>> getProduct() async {
//     try {
//       final data =
//           await db.collection("products").get()
      

//       //Logger.i(data['name']);

//       return right(user);
//     } catch (e) {
//       return left(CleanFailure(error: e.toString(), tag: 'Get UserData'));
//     }
//   }

// }