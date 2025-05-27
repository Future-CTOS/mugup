import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../infrastructure/version_management/models/version_management_model.dart';
import '../../../infrastructure/version_management/models/version_management_status.dart';
import '../../../infrastructure/version_management/models/version_management_view_model.dart';
import '../../../infrastructure/version_management/repositories/version_management_repository.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    isLoading = autoLoginOnStart;
    WidgetsBinding.instance.addPostFrameCallback((final _) => _checkVersion());
    super.onInit();
  }

  final RxBool hasConnectionError = false.obs;
  final RxBool showRetryButton = false.obs;
  final _repository = VersionManagementRepository();
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

    final response = await _repository.version();

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
}
