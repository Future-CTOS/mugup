import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/utils.dart';
import '../models/enum/menu_category.dart';
import '../models/enum/product_filter_category.dart';
import '../models/menu_item_view_model.dart';
import '../models/offer_banner_view_model.dart';
import '../repositories/home_page_repository.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  late final PageController pageController;
  late final TabController tabOfferBannerController;
  late final TabController tabBarCoffeeTypeController;
  late final ScrollController scrollPageController;

  final TextEditingController textController = TextEditingController();

  final HomePageRepository _repository = HomePageRepository();

  final RxList<OfferBannerViewModel> offerBanners =
      <OfferBannerViewModel>[].obs;

  final RxList<MenuItemViewModel> menuItems = <MenuItemViewModel>[].obs;
  final RxList<int> _selectedFilterIds = <int>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isItemsLoading = false.obs;
  final RxBool isBannerHovered = false.obs;

  final RxInt currentPage = 0.obs;
  final RxInt currentTabIndex = MenuCategory.coffee.id.obs;
  final RxInt currentTabNavigationIndex = 0.obs;
  final RxDouble scrollOffset = 0.0.obs;

  @override
  void onInit() async {
    pageController = PageController();
    _initScrollController();
    _initTabBarCoffeeType();
    await _initOfferBanners();
    await _fetchMenuItems();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    tabOfferBannerController.dispose();
    tabBarCoffeeTypeController.dispose();
    scrollPageController.dispose();
    textController.dispose();
    super.dispose();
  }

  void _initScrollController() {
    scrollPageController = ScrollController();

    // scrollPageController.addListener(
    //   () => scrollOffset.value = scrollPageController.offset,
    // );
  }

  Future<void> _initTabBarCoffeeType() async {
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
      if (isFilterButtonSelected) {
        await _filterMenuItems();
      } else {
        await _fetchMenuItems();
      }
    });
  }

  Future<void> _initOfferBanners() async {
    await _fetchOfferBanners();
    tabOfferBannerController = TabController(
      length: offerBanners.length,
      vsync: this,
    );
    _startAutoPageScroll();
  }

  Future<void> _fetchOfferBanners() async {
    isLoading.value = true;
    offerBanners.clear();
    final Either<String, List<OfferBannerViewModel>> result =
        await _repository.getAllOfferBanners();
    isLoading.value = false;

    result.fold((final _) => Utils.showRetryDialog(_fetchOfferBanners), (
      banners,
    ) {
      offerBanners.value = banners;
      offerBanners.removeWhere((item) => item.picture == null);
    });
  }

  Future<void> _fetchMenuItems() async {
    isItemsLoading.value = true;
    menuItems.clear();
    final Either<String, List<MenuItemViewModel>> result = await _repository
        .getMenuItems(currentTabIndex.value);
    isItemsLoading.value = false;

    result.fold(
      (final _) => Utils.showRetryDialog(_fetchMenuItems),
      (items) => menuItems.value = items,
    );
  }

  Future<void> _filterMenuItems() async {
    isItemsLoading.value = true;
    final Either<String, List<MenuItemViewModel>> result = await _repository
        .filterMenuItemsById(
          productType: currentTabIndex.value,
          rate: _selectedFilterIds.contains(ProductFilterCategory.rating.id),
          sortByPriceOrder: _selectedFilterIds.contains(
            ProductFilterCategory.price.id,
          ),
          withDiscount: _selectedFilterIds.contains(
            ProductFilterCategory.discount.id,
          ),
        );
    isItemsLoading.value = false;

    result.fold((final _) => Utils.showRetryDialog(_fetchMenuItems), (
      final items,
    ) {
      menuItems.clear();
      menuItems.value = items;
    });
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

  Future<void> onTapFilterProductItem(int filterCategoryId) async {
    if (_selectedFilterIds.contains(filterCategoryId)) {
      _selectedFilterIds.remove(filterCategoryId);
      await _fetchMenuItems();
      return;
    }
    _selectedFilterIds.add(filterCategoryId);
    await _filterMenuItems();
  }

  Future<void> checkForUpdateItems() async {
    if (_selectedFilterIds.isEmpty) {
      await _fetchMenuItems();
      return;
    }

    await _filterMenuItems();
  }

  bool isSelectedFilterItem(int filterId) =>
      _selectedFilterIds.contains(filterId);

  // todo: set with width screen of device
  bool get isOfferBannerVisible => scrollOffset < 10;

  bool get isFilterButtonSelected => _selectedFilterIds.isNotEmpty;

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
