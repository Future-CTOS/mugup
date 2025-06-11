class RepositoryUrls {
  RepositoryUrls._();

  static const String _baseUrl = 'http://localhost:3000';
  static const String _products = '/products';
  static const String _banners = '/banners';

  static Uri get checkConnection => Uri.parse(_baseUrl);

  static Uri get getOfferBanner => Uri.http(_baseUrl, _banners);

  static Uri getMenuItems(int productType) =>
      Uri.parse('$_baseUrl$_products?productType=$productType');
}
