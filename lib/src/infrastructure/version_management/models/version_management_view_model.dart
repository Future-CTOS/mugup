class VersionManagementViewModel {
  VersionManagementViewModel({
    required this.hasBreakingChanges,
    required this.latestBuildNumber,
    required this.latestChangeLog,
  });

  factory VersionManagementViewModel.fromJson(Map<String, dynamic> json) =>
      VersionManagementViewModel(
        hasBreakingChanges: json['hasBreakingChanges'],
        latestBuildNumber: json['latestBuildNumber'],
        latestChangeLog: json['latestChangeLog'],
      );

  final bool hasBreakingChanges;
  final int latestBuildNumber;
  final String latestChangeLog;
}
