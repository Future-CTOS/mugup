class RepositoryUrls {
  RepositoryUrls._();

  static const String _baseUrl = 'http://localhost:3000';
  static const String _products = '/products';
  static const String _banners = '/banners';

  static Uri get checkConnection => Uri.parse(_baseUrl);

  static Uri get getOfferBanner => Uri.parse(_baseUrl + _banners);

  static Uri getMenuItems(int productType) =>
      Uri.parse('$_baseUrl$_products?productType=$productType');

  static Uri filterProducts({
    required int productType,
    bool? rate,
    bool? onlyWithDiscount,
    bool? sortByPriceOrder,
  }) {
    final queryParameters = <String, dynamic>{
      'productType': productType.toString(),
    };

    if (rate == true) {
      queryParameters['rate_gte'] = '4.5';
    }

    if (onlyWithDiscount == true) {
      queryParameters['beforeDiscountedPrice_ne'] = 'null';
    }

    if (sortByPriceOrder == true) {
      queryParameters['_sort'] = 'price';
      queryParameters['_order'] = 'asc';
    }

    return Uri.parse(
      _baseUrl + _products,
    ).replace(queryParameters: queryParameters);
  }

  static Uri fetchDetailsProductById({required int id}) =>
      Uri.parse('$_baseUrl$_products/$id');
}
