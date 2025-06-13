class FavouriteProductModel {
  final int id;
  final int productId;
  final int userId;

  FavouriteProductModel({
    required this.id,
    required this.productId,
    required this.userId,
  });

  factory FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavouriteProductModel(
      id: json['id'],
      productId: json['productId'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'productId': productId, 'user_id': userId};
  }
}
