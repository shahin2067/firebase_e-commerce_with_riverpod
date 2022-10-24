import 'package:e_commerce_app_with_firebase_riverpod/application/app/product/product_state.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/app/product/i_product_repo.dart';
import 'package:e_commerce_app_with_firebase_riverpod/infrastracture/app/product/product_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
//   return UserNotifier(UserRepo());
// });
final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ProductRepo());
});

class ProductNotifier extends StateNotifier<ProductState> {
  final IProductRepo productRepo;
  ProductNotifier(this.productRepo) : super(ProductState.init());
  getProducts() async {
    state = state.copyWith(loading: true);
    final data = await productRepo.getProduct();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, products: r));
  }
}
