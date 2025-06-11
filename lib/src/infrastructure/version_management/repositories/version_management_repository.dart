import 'package:either_dart/either.dart';

import '../models/version_management_view_model.dart';

class VersionManagementRepository {
  Future<Either<String, VersionManagementViewModel>> version() async {
    return Right(
      VersionManagementViewModel(
        hasBreakingChanges: true,
        latestBuildNumber: 3,
        latestChangeLog: 'fix yours',
      ),
    );
  }
}
