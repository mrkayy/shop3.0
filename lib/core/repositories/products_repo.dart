import 'package:dio/dio.dart';
import 'package:shop3/core/services/dio_reqmgr.dart';
import 'package:shop3/core/services/endpoints.dart';

abstract interface class ProductsInterface {
  Future<Response> category();
  Future<Response> getProductsByCategoryID(int id);
  Future<Response> getSingleProductBySlug(String slug);
  Future<Response> getSingleProductCategoriesBySlug(String slug);
}

final class ProductsRepo implements ProductsInterface {
  ProductsRepo(this._apiService);
  DioRequestManager _apiService;
  @override
  Future<Response> category() async {
    try {
       Response response = await _apiService.getRequest(Endpoints.productCategories);
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }

  @override
  Future<Response> getProductsByCategoryID(int id) async {
    try {
       Response response = await _apiService.getRequest(Endpoints.productByCategoriesID(id));
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }

  @override
  Future<Response> getSingleProductBySlug(String slug) async {
    try {
       Response response = await _apiService.getRequest(Endpoints.productBySlug(slug));
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }

  @override
  Future<Response> getSingleProductCategoriesBySlug(String slug) async {
    try {
       Response response = await _apiService.getRequest(Endpoints.productCategoriesBySlug(slug));
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }
}
