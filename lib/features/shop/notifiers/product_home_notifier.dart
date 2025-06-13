import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shop3/features/shop/models/product_category_model.dart';
import 'package:shop3/features/shop/view_models/products_home_viewmodel.dart';

part 'product_home_notifier.g.dart';

@riverpod
class ProductsHomeViewModelNotifier extends _$ProductsHomeViewModelNotifier {
  @override
  ProductsHomeViewModel build() {
    return ProductsHomeViewModel();
  }

  Future<void> selectCategory(CategoryModel category) async {
    state = state.copyWith(category: category, categorySlug: category.slug);
  }
}
