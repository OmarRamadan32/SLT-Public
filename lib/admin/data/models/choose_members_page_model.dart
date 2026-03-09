class ChooseMembersPageModel {
  final String? documentId;
  final Function onSaved;
  final String? fieldName;
  final int? userNumber;
  final bool? isNewUsers;
  final Map<String, dynamic>? where;

  ChooseMembersPageModel({
    this.documentId,
    required this.onSaved,
    this.fieldName,
    this.userNumber,
    this.isNewUsers,
    this.where
  });
}
