class OfferBannerViewModel {
  OfferBannerViewModel({required this.id, required this.url});

  factory OfferBannerViewModel.fromJson(Map<String, dynamic> json) =>
      OfferBannerViewModel(id: json['id'], url: json['url']);

  final int id;
  final String url;
}
