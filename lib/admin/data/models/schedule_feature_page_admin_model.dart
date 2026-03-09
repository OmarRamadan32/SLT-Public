class ScheduleFeaturePageAdminModel {
  final String? scheduleType;
  final List<String>? scheduleMembersIds;
  final List<String>? scheduleMembersTokens;
  final bool isTeamSchedule;
  final String? scheduleAuthorName;

  ScheduleFeaturePageAdminModel({
     this.scheduleType,
     this.scheduleMembersIds,
     this.scheduleMembersTokens,
    required this.isTeamSchedule,
     this.scheduleAuthorName,
  });
}
