import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mugup/src/pages/shared/views/dialogs/retry_dialog.dart';
import '../models/offer_banner_view_model.dart';
import '../repositories/home_page_repository.dart';

class HomePageController extends GetxController {
  final pageController = PageController(/*viewportFraction: 0.9*/);

  final textController = TextEditingController();
  final _repository = HomePageRepository();

  RxList<OfferBannerViewModel> offerBanners =
      <OfferBannerViewModel>[
        OfferBannerViewModel(id: 1, url: 'url'),
        OfferBannerViewModel(id: 2, url: 'url'),
        OfferBannerViewModel(id: 3, url: 'url'),
      ].obs;

  RxBool isLoading = false.obs;
  final currentPage = 0.obs;

  Future<void> getAllOfferBanners() async {
    isLoading(true);
    final Future<Either<String, List<OfferBannerViewModel>>> resultOrException =
        _repository.getAllOfferBanners();
    isLoading(false);

    resultOrException.fold(
      (_) => RetryDialog(onRetryTapped: getAllOfferBanners),
      (final banners) => offerBanners.value = banners,
    );
  }

  void _startAutoScroll() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (pageController.hasClients) {
        final next = (currentPage.value + 1) % offerBanners.length;
        pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        currentPage.value = next;
      }
      return true;
    });
  }

  @override
  void onInit() {
    _startAutoScroll();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
