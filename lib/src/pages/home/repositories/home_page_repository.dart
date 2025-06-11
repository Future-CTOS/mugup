import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../../infrastructure/commons/repository_urls.dart';
import '../models/menu_item_view_model.dart';
import '../models/offer_banner_view_model.dart';

class HomePageRepository {
  Future<Either<String, List<OfferBannerViewModel>>>
  getAllOfferBanners() async {
    try {
      int? statusCode;
      final http.Response response = await http.get(
        RepositoryUrls.getOfferBanner,
      );
      final List<dynamic> jsonData = json.decode(response.body);
      statusCode = response.statusCode;
      if (statusCode == 200) {
        final List<OfferBannerViewModel> banners =
            jsonData.map((e) => OfferBannerViewModel.fromJson(e)).toList();
        return Right(banners);
      } else {
        return const Left('failed to get offer banners');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<MenuItemViewModel>>> getMenuItems(
    int productType,
  ) async {
    try {
      int? statusCode;
      final http.Response response = await http.get(
        RepositoryUrls.getMenuItems(productType),
      );
      final List<dynamic> jsonData = json.decode(response.body);
      statusCode = response.statusCode;
      if (statusCode == 200) {
        final List<MenuItemViewModel> items =
            jsonData.map((json) => MenuItemViewModel.fromJson(json)).toList();
        return Right(items);
      } else {
        return const Left('failed to get menu items');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
