class Endpoints {
  /// POST:
  static String get signinUser => '/auth/login';

  /// POST:
  static String get signupUser => '/users/';

  /// POST:
  static String get isEmailAvaliable => '/users/is-available';

  /// PUT:
  /// #### Request Body;
  ///   {
  ///     "email": "john@mail.com",
  ///     "name": "Change name"
  ///   }
  static Function(int) get updateUserProfile => (int id) => '/users/$id';

  /// GET:
  static String get userProfile => '/auth/profile';

  /// GET:
  static Function(String) get productBySlug =>
      (String slug) => '/products/slug/$slug';

  /// GET:
  static Function(int) get productByCategoriesID =>
      (int id) => '/categories/$id/products';

  /// GET:
  static String get productCategories => '/categories';

  /// GET:
  static Function(String) get productCategoriesBySlug =>
      (String slug) => '/categories/slug/$slug';
}
