import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_slt/features/posts/data/models/post_fields.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';

class PostModel {
  final String postAuthorId;
  final String? postAuthorName;
  final String? postAuthorImage;
  final int? postAuthorAccessLevel;
  final List<dynamic> postImages;
  String postContent;
  final bool pending;
  final DateTime postDate;
  final bool isSpecialPost;
  String? specialpostNote;
  int? specialPostSignersMaxCount;
  final List<UserModel>? specialPostSigners;
  String? postTitle;
  final String? postId;

  PostModel({
    required this.postAuthorId,
    this.postAuthorName,
    this.postAuthorImage,
    this.postAuthorAccessLevel,
    required this.postImages,
    required this.postContent,
    required this.isSpecialPost,
    required this.pending,
    required this.postDate,
    this.specialpostNote,
    this.specialPostSigners,
    this.specialPostSignersMaxCount,
    this.postId,
    this.postTitle,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postImages: json[PostFields.postImages],
      postAuthorId: json[PostFields.postAuthorId],
      postAuthorName: json[PostFields.postAuthorName],
      postAuthorImage: json[PostFields.postAuthorImage],
      postAuthorAccessLevel: json[PostFields.postAuthorAccessLevel],
      postContent: json[PostFields.postContent],
      isSpecialPost: json[PostFields.isSpecialPost],
      specialpostNote: json[PostFields.specialpostNote],
      specialPostSigners: List<UserModel>.from(
        (json[PostFields.specialPostSigners] ?? []).map((e) => e as UserModel),
      ),
      postId: json[PostFields.postId],
      postDate: (json[PostFields.postDate] as Timestamp).toDate(),
      specialPostSignersMaxCount: json[PostFields.specialPostSignersMaxCount],
      postTitle: json[PostFields.postTitle],
      pending: json[PostFields.pending] ?? true,
    );
  }
  factory PostModel.fakeModel() {
    return PostModel(
      postImages: [],
      postId: "1234",
      postAuthorId: "123",
      postAuthorName: "اسم الشخص",
      postAuthorImage: "صورة",
      postAuthorAccessLevel: 0,
      postContent:
          "ده بوست ملوش اي لازمه ومش هيظهر اصلا ولو ظهر ف انت سعيد الحظ وكسبت معانا جنية دهب ياعم",
      isSpecialPost: false,
      specialpostNote: "",
      specialPostSigners: [],
      specialPostSignersMaxCount: 0,
      postDate: DateTime.now(),
      postTitle: "",
      pending: false,
    );
  }

  factory PostModel.fromJsonWithoutSigners(Map<String, dynamic> json) {
    return PostModel(
      postImages: json[PostFields.postImages],
      postAuthorId: json[PostFields.postAuthorId],
      postAuthorName: json[PostFields.postAuthorName],
      postAuthorImage: json[PostFields.postAuthorImage],
      postAuthorAccessLevel: json[PostFields.postAuthorAccessLevel],
      postContent: json[PostFields.postContent],
      isSpecialPost: json[PostFields.isSpecialPost],
      postId: json[PostFields.postId],
      specialpostNote: json[PostFields.specialpostNote],
      specialPostSignersMaxCount: json[PostFields.specialPostSignersMaxCount],
      postDate: (json[PostFields.postDate] as Timestamp).toDate(),
      postTitle: json[PostFields.postTitle],
      pending: json[PostFields.pending] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PostFields.postImages: postImages,
      PostFields.postAuthorId: postAuthorId,
      PostFields.postAuthorName: postAuthorName,
      PostFields.postAuthorImage: postAuthorImage,
      PostFields.postAuthorAccessLevel: postAuthorAccessLevel,
      PostFields.postContent: postContent,
      PostFields.isSpecialPost: isSpecialPost,
      PostFields.specialpostNote: specialpostNote,
      PostFields.specialPostSigners: specialPostSigners,
      PostFields.specialPostSignersMaxCount: specialPostSignersMaxCount,
      PostFields.postDate: postDate,
      PostFields.postTitle: postTitle,
      PostFields.pending: pending,
    };
  }

  Map<String, dynamic> toJsonWithoutSigners() {
    return {
      PostFields.postImages: postImages,
      PostFields.postAuthorId: postAuthorId,
      PostFields.postAuthorName: postAuthorName,
      PostFields.postAuthorImage: postAuthorImage,
      PostFields.postAuthorAccessLevel: postAuthorAccessLevel,
      PostFields.postContent: postContent,
      PostFields.isSpecialPost: isSpecialPost,
      PostFields.specialpostNote: specialpostNote,
      PostFields.specialPostSignersMaxCount: specialPostSignersMaxCount,
      PostFields.postDate: postDate,
      PostFields.postTitle: postTitle,
      PostFields.pending: pending,
    };
  }
}
