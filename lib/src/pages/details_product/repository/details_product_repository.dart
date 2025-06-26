import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../infrastructure/commons/repository_urls.dart';
import '../models/details_product_view_model.dart';

class DetailsProductRepository {
  Future<Either<String, DetailsProductViewModel>> fetchDetailsProduct({
    required int productId,
  }) async {
    int? statusCode;
    try {
      final http.Response response = await http.get(
        RepositoryUrls.fetchDetailsProductById(id: productId),
      );
      final Map<String, dynamic> jsonData = json.decode(response.body);
      statusCode = response.statusCode;
      if (statusCode == 200) {
        return Right(DetailsProductViewModel.fromJson(jsonData));
      }
    } on SocketException {
      if (kDebugMode) {
        return Left('there is\'nt connect to the internet');
      }
    } on HttpException {
      if (kDebugMode) {
        return Left('error for send request to server');
      }
    } on FormatException {
      if (kDebugMode) {
        return Left('received invalid response from the internet');
      }
    } catch (e) {
      return Left(
        'something went wrong status code: $statusCode , error-> ${e.toString()}',
      );
    }
    return Left('failed to get details product');
  }
}
