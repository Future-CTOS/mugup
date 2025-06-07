import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/views/dialogs/retry_dialog.dart';
import '../models/offer_banner_view_model.dart';
import '../repositories/home_page_repository.dart';
import '../views/url_example.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  late final PageController pageController;
  late final TabController tabController;
  final textController = TextEditingController();

  final _repository = HomePageRepository();

  RxList<OfferBannerViewModel> offerBanners =
      <OfferBannerViewModel>[
        OfferBannerViewModel(id: 1, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 2, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 3, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 4, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 5, imageBytes: UrlExample.value1),
      ].obs;

  RxBool isLoading = false.obs;
  RxBool isBannerHovered = false.obs;
  RxInt currentPage = 0.obs;

  Future<void> _getAllOfferBanners() async {
    isLoading(true);
    final Either<String, List<OfferBannerViewModel>> resultOrException =
        await _repository.getAllOfferBanners();
    isLoading(false);

    resultOrException.fold(
      (_) => RetryDialog(onRetryTapped: _getAllOfferBanners),
      (final banners) => offerBanners.value = banners,
    );
  }

  void animatedToBannerPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    currentPage.value = pageIndex;
    tabController.index = pageIndex;
  }

  void _startAutoPageScroll() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 7));
      if (pageController.hasClients) {
        final next = (currentPage.value + 1) % offerBanners.length;
        animatedToBannerPage(next);
      }
      return true;
    });
  }

  void onNavigateToNextBanner() {
    final next = (currentPage.value + 1) % offerBanners.length;
    animatedToBannerPage(next);
  }

  void onNavigateToPreviousBanner() {
    final previous = (currentPage.value - 1) % offerBanners.length;
    animatedToBannerPage(previous);
  }

  void onBannerChange(int index) {
    tabController.index = index;
    currentPage.value = index;
  }

  void onBannerHover(PointerEvent _) => isBannerHovered.value = true;

  void onBannerHoverExit(PointerEvent _) => isBannerHovered.value = false;

  bool get isOnDesktopAndWeb =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.windows ||
        TargetPlatform.linux ||
        TargetPlatform.macOS => true,
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.fuchsia => false,
      };

  Future<void> _initOfferBanners() async {
    await _getAllOfferBanners();
    tabController = TabController(length: offerBanners.length, vsync: this);
    _startAutoPageScroll();
  }

  @override
  void onInit() async {
    pageController = PageController();
    _initOfferBanners();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    tabController.dispose();
    super.dispose();
  }
}
