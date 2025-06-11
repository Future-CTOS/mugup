import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/views/dialogs/retry_dialog.dart';
import '../models/enum/menu_category.dart';
import '../models/menu_item_view_model.dart';
import '../models/offer_banner_view_model.dart';
import '../repositories/home_page_repository.dart';
import '../views/url_example.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  late final PageController pageController;
  late final TabController tabOfferBannerController;
  late final TabController tabBarCoffeeTypeController;
  late final ScrollController scrollPageController;
  late final ScrollController scrollTabBarViewsController;

  final TextEditingController textController = TextEditingController();

  final HomePageRepository _repository = HomePageRepository();

  final RxList<OfferBannerViewModel> offerBanners =
      <OfferBannerViewModel>[
        OfferBannerViewModel(id: 1, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 2, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 3, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 4, imageBytes: UrlExample.value1),
        OfferBannerViewModel(id: 5, imageBytes: UrlExample.value1),
      ].obs;

  final RxList<MenuItemViewModel> menuItems = <MenuItemViewModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isItemsLoading = false.obs;
  final RxBool isBannerHovered = false.obs;

  final RxInt currentPage = 0.obs;
  final RxInt currentTabIndex = MenuCategory.coffee.id.obs;
  final RxDouble scrollOffset = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();

    pageController = PageController();
    _initScrollControllers();
    _initTabBarCoffeeType();
    await _initOfferBanners();
    await _fetchMenuItems();
  }

  @override
  void dispose() {
    pageController.dispose();
    tabOfferBannerController.dispose();
    tabBarCoffeeTypeController.dispose();
    scrollPageController.dispose();
    scrollTabBarViewsController.dispose();
    textController.dispose();
    super.dispose();
  }

  void _initScrollControllers() {
    scrollPageController = ScrollController();
    scrollTabBarViewsController = ScrollController();

    void updateScrollOffset() {
      final offset =
          scrollPageController.hasClients
              ? scrollPageController.position.pixels
              : scrollTabBarViewsController.hasClients
              ? scrollTabBarViewsController.position.pixels
              : 0.0;
      scrollOffset.value = offset;
    }

    scrollPageController.addListener(updateScrollOffset);
    scrollTabBarViewsController.addListener(updateScrollOffset);
  }

  void _initTabBarCoffeeType() {
    tabBarCoffeeTypeController = TabController(
      length: MenuCategory.values.length,
      initialIndex: currentTabIndex.value,
      vsync: this,
    );

    tabBarCoffeeTypeController.addListener(() async {
      if (tabBarCoffeeTypeController.indexIsChanging) {
        return;
      }
      currentTabIndex.value = tabBarCoffeeTypeController.index;
      await _fetchMenuItems();
    });
  }

  Future<void> _initOfferBanners() async {
    tabOfferBannerController = TabController(
      length: offerBanners.length,
      vsync: this,
    );

    await _fetchOfferBanners();
    _startAutoPageScroll();
  }

  Future<void> _fetchOfferBanners() async {
    isLoading.value = true;
    final Either<String, List<OfferBannerViewModel>> result =
        await _repository.getAllOfferBanners();
    isLoading.value = false;

    result.fold(
      (error) => RetryDialog(onRetryTapped: _fetchOfferBanners),
      (banners) => offerBanners.value = banners,
    );
  }

  Future<void> _fetchMenuItems() async {
    isItemsLoading.value = true;
    final Either<String, List<MenuItemViewModel>> result = await _repository
        .getMenuItems(currentTabIndex.value);
    isItemsLoading.value = false;

    result.fold(
      (error) => RetryDialog(onRetryTapped: _fetchMenuItems),
      (items) => menuItems.value = items,
    );
  }

  void _startAutoPageScroll() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 7));
      if (!pageController.hasClients) return true;

      final nextPage = (currentPage.value + 1) % offerBanners.length;
      animateToBannerPage(nextPage);

      return true;
    });
  }

  void animateToBannerPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    currentPage.value = pageIndex;
    tabOfferBannerController.index = pageIndex;
  }

  void onNavigateToNextBanner() =>
      animateToBannerPage((currentPage.value + 1) % offerBanners.length);

  void onNavigateToPreviousBanner() {
    final prev = currentPage.value - 1;
    final previousPage = prev < 0 ? offerBanners.length - 1 : prev;
    animateToBannerPage(previousPage);
  }

  void onBannerChange(int index) {
    tabOfferBannerController.index = index;
    currentPage.value = index;
  }

  void onBannerHover(PointerEvent _) => isBannerHovered.value = true;

  void onBannerHoverExit(PointerEvent _) => isBannerHovered.value = false;

  bool get isOfferBannerVisible => scrollOffset.value < 120;

  bool get isOnDesktopAndWeb {
    if (kIsWeb) return true;

    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        return true;
      default:
        return false;
    }
  }
}
