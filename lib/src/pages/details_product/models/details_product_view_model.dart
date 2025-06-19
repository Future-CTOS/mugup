import 'dart:convert';
import 'dart:typed_data';

class DetailsProductViewModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rate;
  final Uint8List? avatar;

  DetailsProductViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rate,
    required String? avatar,
  }) : avatar =
           (avatar != null && avatar.isNotEmpty) ? base64.decode(avatar) : null;

  factory DetailsProductViewModel.fromJson(final Map<String, dynamic> json) =>
      DetailsProductViewModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        rate: json['rate'],
        avatar: json['avatar'],
      );
}
