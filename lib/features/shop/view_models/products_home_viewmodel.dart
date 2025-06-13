import 'package:equatable/equatable.dart';
import 'package:shop3/features/shop/models/product_category_model.dart';

class ProductsHomeViewModel extends Equatable {
  ProductsHomeViewModel({this.categorySlug, this.category});
  final String? categorySlug;
  final CategoryModel? category;

  ProductsHomeViewModel copyWith({
    String? categorySlug,
    CategoryModel? category,
  }) => ProductsHomeViewModel(
    categorySlug: categorySlug ?? this.categorySlug,
    category: category ?? this.category,
  );

  @override
  List<Object?> get props => [categorySlug, category];
}
