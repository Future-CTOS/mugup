import 'dart:convert';

import 'package:flutter/foundation.dart';

class OfferBannerViewModel {
  OfferBannerViewModel({required this.id, required String? banner})
    : picture =
          (banner != null && banner.isNotEmpty) ? base64.decode(banner) : null;

  factory OfferBannerViewModel.fromJson(Map<String, dynamic> json) =>
      OfferBannerViewModel(id: json['id'], banner: json['url']);

  final double id;
  final Uint8List? picture;
}
