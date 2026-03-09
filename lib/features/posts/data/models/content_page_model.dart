class ContentPageModel {
  final String contentAuthorName;
  final String contentAuthorImage;
  final String contentAuthorID;
  final String contentText;
  final DateTime contentDate;
  List<dynamic>? postImages;
  String? contentID;

  ContentPageModel({
    required this.contentAuthorName,
    required this.contentAuthorImage,
    required this.contentText,
    required this.contentDate,
    required this.contentAuthorID,
    this.postImages,
    this.contentID,
  });
}
