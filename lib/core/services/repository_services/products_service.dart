import 'package:dio/dio.dart';
import 'package:shop3/core/repositories/products_repo.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/utils/typedef.dart';
import 'package:shop3/features/shop/models/product_category_model.dart';
import 'package:shop3/features/shop/models/products_model.dart';

class ProductServices {
  ProductServices(this._api);

  final ProductsInterface _api;

  EitherErrorOrResponse<List<ProductModel>?> fetchAllProductsByCategory(
    int id,
  ) async {
    Response res = await _api.getProductsByCategoryID(id);
    try {
      if (res.statusCode! >= 200) {
        var products =
            (res.data as List)
                .map((json) => ProductModel.fromJson(json))
                .toList();
        return (err: null, res: products);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');
      return (err: error, res: null);
    }
    var error = res.data as ErrorParser;
    return (err: error, res: null);
  }

  EitherErrorOrResponse<ProductModel?> fetchProductBySlug(String slug) async {
    Response res = await _api.getSingleProductBySlug(slug);
    try {
      if (res.statusCode! >= 200) {
        var product = ProductModel.fromJson(res.data);
        return (err: null, res: product);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');
      return (err: error, res: null);
    }
    var error = res.data as ErrorParser;
    return (err: error, res: null);
  }

  EitherErrorOrResponse<CategoryModel?> fetchCategoriesBySlug(
    String slug,
  ) async {
    Response res = await _api.getSingleProductCategoriesBySlug(slug);
    try {
      if (res.statusCode! >= 200) {
        var product = CategoryModel.fromJson(res.data);
        return (err: null, res: product);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');
      return (err: error, res: null);
    }
    var error = res.data as ErrorParser;
    return (err: error, res: null);
  }

  EitherErrorOrResponse<List<CategoryModel>?> fetchCategories() async {
    Response res = await _api.category();
    try {
      if (res.statusCode! >= 200) {
        var categories =
            (res.data as List)
                .map((json) => CategoryModel.fromJson(json))
                .toList();
        return (err: null, res: categories);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');
      return (err: error, res: null);
    }
    var error = res.data as ErrorParser;
    return (err: error, res: null);
  }
}
