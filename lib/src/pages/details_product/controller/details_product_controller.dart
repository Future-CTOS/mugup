import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:mugup/src/pages/shared/views/dialogs/retry_dialog.dart';

import '../models/details_product_view_model.dart';
import '../repository/details_product_repository.dart';

class DetailsProductController extends GetxController {
  DetailsProductController({required this.productId});

  final _repository = DetailsProductRepository();

  final int? productId;

  final RxBool isLoading = false.obs;

  DetailsProductViewModel? detailsProduct;

  List example = [
    '1',
    'A',
    'B',
    'C',
    'SS',
    'CAA',
    'CAA-sd',
    'CASS',
    'MMI',

    '1',
    'A',
    'B',
    'C',
    'SS',
    'CAA',
    'CAA-sd',
    'CASS',
    'MMI',

    '1',
    'A',
    'B',
    'C',
    'SS',
    'CAA',
    'CAA-sd',
    'CASS',
    'MMI',
    '1',
    'A',
    'B',
    'C',
    'SS',
    'CAA',
    'CAA-sd',
    'CASS',
    'MMI',
    '1',
    'A',
    'B',
    'C',
    'SS',
    'CAA',
    'CAA-sd',
    'CASS',
    'MMI',
  ];
  List example2 = ['Variant', 'Babeee', 'hesam', 'hamed', 'MIJI', 'mioo'];

  @override
  Future<void> onInit() async {
    if (productId != null) {
      await _fetchDetailsProductById(productId!);
    }
    super.onInit();
  }

  Future<void> _fetchDetailsProductById(int id) async {
    isLoading(true);
    final Either<String, DetailsProductViewModel> resultOrException =
        await _repository.fetchDetailsProduct(productId: id);
    isLoading(false);

    resultOrException.fold(
      (final _) =>
          RetryDialog(onRetryTapped: () => _fetchDetailsProductById(id)),
      (final product) => detailsProduct = product,
    );
  }
}
