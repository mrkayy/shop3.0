import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shop3/core/repositories/products_repo.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/services/repository_services/products_service.dart';
import 'package:shop3/di_manager.dart';
import 'package:shop3/features/shop/models/products_model.dart';

part 'get_products_provider.g.dart';


@riverpod
Future<List<ProductModel>> fetchProductsFromCategories(Ref ref, int id) async {
  var service = await ProductServices(getIt<ProductsInterface>());

  try {
    final res = await service.fetchAllProductsByCategory(id);

    if (res.err == null) {
      return res.res ?? [];
    } else {
      return [];
    }
  } catch (e) {
    throw ProviderException('Error: $e');
  }
}
