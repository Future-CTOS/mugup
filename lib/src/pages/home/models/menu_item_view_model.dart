import 'dart:convert';
import 'dart:typed_data';

class MenuItemViewModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double? discountedPrice;
  final double rate;
  final Uint8List? avatar;

  MenuItemViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountedPrice,
    required this.rate,
    required String? avatar,
  }) : avatar =
           (avatar != null && avatar.isNotEmpty) ? base64.decode(avatar) : null;

  factory MenuItemViewModel.fromJson(final Map<String, dynamic> json) =>
      MenuItemViewModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discountedPrice: json['discountedPrice'],
        rate: json['rate'],
        avatar: json['avatar'],
      );
}
