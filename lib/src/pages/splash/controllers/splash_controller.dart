import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mugup/src/infrastructure/routes/route_names/route_names.dart';
import 'package:mugup/src/pages/shared/views/dialogs/retry_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../infrastructure/version_management/models/version_management_model.dart';
import '../../../infrastructure/version_management/models/version_management_status.dart';
import '../../../infrastructure/version_management/models/version_management_view_model.dart';
import '../../../infrastructure/version_management/repositories/version_management_repository.dart';
import '../repositories/splash_repository.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
      (final _) => _checkUsableVersion(),
    );
    super.onInit();
  }

  final RxBool hasConnectionError = false.obs;
  final RxBool showRetryButton = false.obs;
  final _versionManagementRepository = VersionManagementRepository();
  final _repository = SplashRepository();
  RxBool autoLoginOnStart = false.obs;
  RxBool isLoading = false.obs;

  Future<VersionManagementModel> _checkVersion() async {
    if (kIsWeb) {
      return VersionManagementModel(
        status: VersionManagementStatus.noUpdateAvailable,
      );
    }

    final packageInfo = await PackageInfo.fromPlatform();

    final buildNumber = int.parse(packageInfo.buildNumber);

    final response = await _versionManagementRepository.version();

    final VersionManagementViewModel versionManagementViewModel =
        response.right;

    if (versionManagementViewModel.hasBreakingChanges ||
        versionManagementViewModel.latestBuildNumber > buildNumber) {
      return VersionManagementModel(
        status: VersionManagementStatus.newUpdate,
        versionManagementViewModel: versionManagementViewModel,
      );
    }

    return VersionManagementModel(
      status: VersionManagementStatus.noUpdateAvailable,
    );
  }

  Future<bool> _checkConnection() async {
    await Future<void>.delayed(1800.milliseconds);
    final bool result = await _repository.checkConnection();

    if (!result) {
      return false;
    }

    return true;
  }

  Future<void> _onConnectionError() async {
    showRetryButton.value = true;
    RetryDialog(onRetryTapped: _onRetryTapped).show(Get.context!);
  }

  Future<void> _onRetryTapped() async {
    showRetryButton.value = false;
    await _checkUsableVersion();
  }

  Future<void> _checkUsableVersion() async {
    final hasConnection = await _checkConnection();

    if (!hasConnection) {
      _onConnectionError();
      return;
    }

    final versionChecking = await _checkVersion();

    if (versionChecking.status == VersionManagementStatus.newUpdate) {
      _showUpdateDialog();
    }

    _onSuccessLogin();
  }

  void _onSuccessLogin() {
    Get.offAndToNamed(RouteNames.home);
  }

  void _showUpdateDialog() {
    Get.defaultDialog(title: 'notComplete');
  }
}
