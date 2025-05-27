import 'version_management_status.dart';
import 'version_management_view_model.dart';

class VersionManagementModel {
  VersionManagementModel({
    required this.status,
    this.versionManagementViewModel,
  });

  final VersionManagementStatus status;
  final VersionManagementViewModel? versionManagementViewModel;
}
