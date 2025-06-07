import 'dart:convert';

import 'package:flutter/foundation.dart';

class OfferBannerViewModel {
  OfferBannerViewModel({required this.id, required String imageBytes})
    : imageBytes = base64Decode(imageBytes);

  factory OfferBannerViewModel.fromJson(Map<String, dynamic> json) =>
      OfferBannerViewModel(id: json['id'], imageBytes: json['url']);

  final double id;
  final Uint8List imageBytes;
}
