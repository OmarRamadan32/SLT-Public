import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/posts/data/models/comment_fields.dart';

class CommentModel {
  final String? commentId;
  final String commentAuthorId;
  final String? commentAuthorName;
  final String? commentAuthorImage;
  final int? commentAuthorAccessLevel;
  final DateTime commentDate;
  final String commentText;
  final List mentions;
  final int? repliesCount;

  CommentModel({
    this.commentId,
    required this.commentAuthorId,
    this.commentAuthorName,
    this.commentAuthorImage,
    this.commentAuthorAccessLevel,
    this.repliesCount,
    required this.commentDate,
    required this.commentText,
    required this.mentions,
  });

  factory CommentModel.fakeModel() {
    return CommentModel(
      mentions: [],
      commentId: 'commentId',
      commentAuthorId: 'commentAuthorId',
      commentAuthorName: 'commentAuthorName',
      commentAuthorImage: 'commentAuthorImage',
      commentAuthorAccessLevel: 1,
      commentDate: DateTime.now(),
      commentText:
          '"-----------------------------------------------------------',
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json[CommentFields.commentId],
      commentAuthorId: json[CommentFields.commentAuthorId],
      commentAuthorName: json[CommentFields.commentAuthorName],
      commentAuthorImage: json[CommentFields.commentAuthorImage],
      commentAuthorAccessLevel: json[CommentFields.commentAuthorAccessLevel],
      commentDate: (json[CommentFields.commentDate] as Timestamp).toDate(),
      commentText: json[CommentFields.commentText],
      repliesCount: json[CommentFields.repliesCount],
      mentions: List<UserModel>.from(
        (json[CommentFields.mentions] as List? ?? []).map(
          (e) => e as UserModel,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CommentFields.commentAuthorId: commentAuthorId,
      CommentFields.commentAuthorName: commentAuthorName,
      CommentFields.commentAuthorImage: commentAuthorImage,
      CommentFields.commentAuthorAccessLevel: commentAuthorAccessLevel,
      CommentFields.commentDate: commentDate,
      CommentFields.commentText: commentText,
      CommentFields.mentions: mentions,
      // CommentFields.repliesCount: repliesCount, <<this is not needed in the Database because we create inside the repo
    };
  }
}
