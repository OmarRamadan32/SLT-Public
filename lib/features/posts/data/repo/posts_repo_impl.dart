import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/posts/data/models/comment_fields.dart';
import 'package:new_slt/features/posts/data/models/comment_model.dart';
import 'package:new_slt/features/posts/data/models/post_fields.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';

class PostsRepoImpl implements PostsRepo {
  DatabaseService db;
  UserRepo userRepo;
  MessageRepo messageRepo;
  final String _commentsCollection = BackendEndpoints.commentsCollection;
  final NotificationService notificationService;
  PostsRepoImpl({
    required this.messageRepo,
    required this.db,
    required this.userRepo,
    required this.notificationService,
  });

  @override
  Future<Either<Failure, void>> addPost({required PostModel postModel}) async {
    try {
      await db.addData(
        path: BackendEndpoints.postsCollection,
        data: postModel.toJson(),
      );
      if (postModel.pending == true) {
        await notificationService.sendNotificationToAccessLevels(
          miniMumAccessLevel: 2,
          title: "بوست جديد",
          body:
              "تم إضافة بوست معلق يرجي التوجة إلي الإشعارات ومراجعته قبل الموافقه عليه",
        );
      } else {
        await notificationService.sendNotificationToAllTeamMembers(
          title: "بوست جديد",
          body: "تم إضافة بوست بواسطة ${postModel.postAuthorName} ",
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost({required String postId}) async {
    try {
      // delete comments first
      await db.deleteData(
        path:
            "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection",
      );
      await db.deleteData(
        path: BackendEndpoints.postsCollection,
        documentId: postId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost({
    required String postId,
    required PostModel postModel,
  }) async {
    try {
      await db.updateData(
        path: BackendEndpoints.postsCollection,
        data: postModel.toJsonWithoutSigners(),
        documentId: postId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts({
    int? limit,
    dynamic startAfter,
  }) async {
    try {
      Map<String, dynamic> query = {
        'orderBy': PostFields.postDate,
        'descending': true,
      };
      if (limit != null) query['limit'] = limit;
      if (startAfter != null) query['startAfterDocument'] = startAfter;

      List<Map<String, dynamic>> data = await db.getData(
        path: BackendEndpoints.postsCollection,
        query: query,
      );
      if (data.isNotEmpty) {
        List<PostModel> posts = await Future.wait({
          ...data.map((e) async {
            // empty signers list to avoid errors
            e[PostFields.specialPostSigners] = [];
            // --------- 1. Author
            final author = await userRepo.getUserById(
              e[PostFields.postAuthorId],
            );
            author.fold(
              (_) {
                e[PostFields.postAuthorName] = "بلا اسم";
                e[PostFields.postAuthorImage] = "";
                e[PostFields.postAuthorAccessLevel] = 0;
              },
              (user) {
                e[PostFields.postAuthorName] = user.name;
                e[PostFields.postAuthorImage] = user.imageUrl;
                e[PostFields.postAuthorAccessLevel] = user.accessLevel;
              },
            );

            // --------- 3. ارجع PostModel جاهز
            return PostModel.fromJson(e);
          }),
        });
        return Right(posts);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, PostModel>> getPostById({
    required String postId,
  }) async {
    try {
      final data = await db.getData(
        path: BackendEndpoints.postsCollection,
        docuementId: postId,
      );
      if (data != null) {
        // --------- 1. Author
        var author = await userRepo.getUserById(data[PostFields.postAuthorId]);
        author.fold(
          (failure) {
            data[PostFields.postAuthorName] = "بدون اسم";
            data[PostFields.postAuthorImage] = null;
            data[PostFields.postAuthorAccessLevel] = 0;
          },
          (user) {
            data[PostFields.postAuthorName] = user.name;
            data[PostFields.postAuthorImage] = user.imageUrl;
            data[PostFields.postAuthorAccessLevel] = user.accessLevel;
          },
          // --------- 2. Signers
        );
        final post = PostModel.fromJsonWithoutSigners(data);
        return Right(post);
      } else {
        return left(const ServerFailure(message: "البوست غير موجود"));
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllUserPosts({
    required String userId,
    int? limit,
    dynamic startAfter,
  }) async {
    try {
      Map<String, dynamic> query = {
        'where': [
          {'field': PostFields.postAuthorId, 'isEqualTo': userId},
        ],
        "orderBy": PostFields.postDate,
        'descending': true,
      };
      if (limit != null) query['limit'] = limit;
      if (startAfter != null) query['startAfterDocument'] = startAfter;

      final List<Map<String, dynamic>> data = await db.getData(
        path: BackendEndpoints.postsCollection,
        query: query,
      );

      if (data.isNotEmpty) {
        List<PostModel> posts = await Future.wait({
          ...data.map((e) async {
            // empty signers list to avoid errors
            e[PostFields.specialPostSigners] = [];
            // --------- 1. Author
            final author = await userRepo.getUserById(
              e[PostFields.postAuthorId],
            );
            author.fold(
              (_) {
                e[PostFields.postAuthorName] = "بلا اسم";
                e[PostFields.postAuthorImage] = "";
                e[PostFields.postAuthorAccessLevel] = 0;
              },
              (user) {
                e[PostFields.postAuthorName] = user.name;
                e[PostFields.postAuthorImage] = user.imageUrl;
                e[PostFields.postAuthorAccessLevel] = user.accessLevel;
              },
            );

            // --------- 3. ارجع PostModel جاهز
            return PostModel.fromJson(e);
          }),
        });
        return Right(posts);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signPost({
    required String postId,
    required String userId,
  }) async {
    var postDoc = await db.getData(
      path: BackendEndpoints.postsCollection,
      docuementId: postId,
    );
    try {
      if (postDoc[PostFields.specialPostSigners].contains(userId)) {
        await db.updateData(
          documentId: postId,
          path: BackendEndpoints.postsCollection,
          data: {
            PostFields.specialPostSigners: FieldValue.arrayRemove([userId]),
          },
        );
      } else if (postDoc[PostFields.specialPostSigners].length <
          postDoc[PostFields.specialPostSignersMaxCount]) {
        await db.updateData(
          documentId: postId,
          path: BackendEndpoints.postsCollection,
          data: {
            PostFields.specialPostSigners: FieldValue.arrayUnion([userId]),
          },
        );
      } else if (postDoc[PostFields.specialPostSigners].length >=
          postDoc[PostFields.specialPostSignersMaxCount]) {
        return left(
          const ServerFailure(message: "تم الوصول للحد الاقصي للتسجيل"),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getApprovedPosts({
    int? limit,
    dynamic startAfter,
  }) async {
    try {
      final Map<String, dynamic> query = {
        'where': [
          {'field': PostFields.pending, 'isEqualTo': false},
        ],
        "orderBy": PostFields.postDate,
        'descending': true,
      };
      if (limit != null) query['limit'] = limit;
      if (startAfter != null) query['startAfterDocument'] = startAfter;

      List<Map<String, dynamic>> data = await db.getData(
        path: BackendEndpoints.postsCollection,
        query: query,
      );
      if (data.isNotEmpty) {
        List<PostModel> posts = await Future.wait({
          ...data.map((e) async {
            // --------- 1. Author
            final author = await userRepo.getUserById(
              e[PostFields.postAuthorId],
            );
            author.fold(
              (_) {
                e[PostFields.postAuthorName] = "بلا اسم";
                e[PostFields.postAuthorImage] = "";
                e[PostFields.postAuthorAccessLevel] = 0;
              },
              (user) {
                e[PostFields.postAuthorName] = user.name;
                e[PostFields.postAuthorImage] = user.imageUrl;
                e[PostFields.postAuthorAccessLevel] = user.accessLevel;
              },
            );
            List<UserModel> signersList = [];
            if (e[PostFields.isSpecialPost]) {
              final signersIds = await userRepo.getUsersByIds(
                List<String>.from(e[PostFields.specialPostSigners] ?? []),
              );
              signersIds.fold((_) => e[PostFields.specialPostSigners] = [], (
                signers,
              ) {
                signersList = signers;
                e[PostFields.specialPostSigners] = signersList;
              });
            }
            // --------- 3. ارجع PostModel جاهز
            return PostModel.fromJson(e);
          }),
        });
        return Right(posts);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getPendingPosts({
    int? limit,
    dynamic startAfter,
  }) async {
    try {
      Map<String, dynamic> query = {
        'where': [
          {'field': PostFields.pending, 'isEqualTo': true},
        ],
        "orderBy": PostFields.postDate,
        'descending': true,
        'limit': limit,
        'startAfterDocument': startAfter,
      };
      if (limit != null) query['limit'] = limit;
      if (startAfter != null) query['startAfterDocument'] = startAfter;
      List<Map<String, dynamic>> data = await db.getData(
        path: BackendEndpoints.postsCollection,
        query: query,
      );

      if (data.isNotEmpty) {
        List<PostModel> posts = await Future.wait({
          ...data.map((e) async {
            // empty signers list to avoid errors
            e[PostFields.specialPostSigners] = [];
            // --------- 1. Author
            final author = await userRepo.getUserById(
              e[PostFields.postAuthorId],
            );
            author.fold(
              (_) {
                e[PostFields.postAuthorName] = "بلا اسم";
                e[PostFields.postAuthorImage] = "";
                e[PostFields.postAuthorAccessLevel] = 0;
              },
              (user) {
                e[PostFields.postAuthorName] = user.name;
                e[PostFields.postAuthorImage] = user.imageUrl;
                e[PostFields.postAuthorAccessLevel] = user.accessLevel;
              },
            );

            // --------- 3. ارجع PostModel جاهز
            return PostModel.fromJson(e);
          }),
        });
        return Right(posts);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> approvePost({
    required String postId,
    required String postAuthorId,
  }) async {
    try {
      await db.updateData(
        documentId: postId,
        path: BackendEndpoints.postsCollection,
        data: {PostFields.pending: false},
      );
      Either<Failure, UserModel> author = await userRepo.getUserById(
        postAuthorId,
      );
      UserModel? authorModel = author.fold(
        (l) => null,
        (userModel) => userModel,
      );
      await notificationService.sendNotificationToUsers(
        title: "فريق القادة الاجتماعيين",
        body: "تم الموافقه علي البوست الخاص بك وسيتم عرضه",
        tokens: [authorModel!.token],
      );
      await notificationService.sendNotificationToAllTeamMembers(
        title: "بوست جديد",
        body: "تم إضافة بوست بواسطة ${authorModel.name} ",
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addComment({
    required String postAuthorId,
    required String postId,
    required CommentModel commentModel,
    String? commentId,
    String? commentAuthorId,
  }) async {
    final String commentsPath =
        commentId == null
            ? "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection"
            : "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection/$commentId/$_commentsCollection";
    try {
      Either<Failure, UserModel> author = await userRepo.getUserById(
        commentAuthorId ?? postAuthorId,
      );
      UserModel? authorModel = author.fold(
        (l) => null,
        (userModel) => userModel,
      );
      // send notifications
      if (commentId == null) {
        await notificationService.sendNotificationToUsers(
          title: "تعليق جديد",
          body: '''
تم التعليق بواسطة ${commentModel.commentAuthorName} علي البوست الخاص بك
(${commentModel.commentText})
''',
          tokens: [authorModel!.token],
        );
      } else {
        await notificationService.sendNotificationToUsers(
          title: "تم الرد علي تعليقك",
          body: '''
تم الرد علي تعليقك بواسطة ${commentModel.commentAuthorName}
(${commentModel.commentText})
''',
          tokens: [authorModel!.token],
        );
      }
      // send Message to Mentioned
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel(
          senderName:
              commentModel.commentAuthorName ?? "فريق القادة الإجتماعيين",
          text:
              "تمت الإشارة إليك بواسطة ${commentModel.commentAuthorName} في تعليق  (${commentModel.commentText})",
          date: DateTime.now(),
          isPrivate: true,
        ),
        usersIds: commentModel.mentions as List<String>,
      );
      await db.addData(path: commentsPath, data: commentModel.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment({
    required String postId,
    required String commentId,
    String? repledCommentId,
  }) async {
    final String commentsPath =
        repledCommentId == null
            ? "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection/"
            : "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection/$repledCommentId/$_commentsCollection";
    try {
      await db.deleteData(path: commentsPath, documentId: commentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments({
    required String postId,
    int? limit,
    dynamic startAfter,
    String? commentId,
  }) async {
    final String commentsPath =
        commentId == null
            ? "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection"
            : "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection/$commentId/$_commentsCollection";
    try {
      // the Query
      Map<String, dynamic> query = {
        "orderBy": CommentFields.commentDate,
        'descending': commentId == null ? true : false, // <<<
      };
      if (limit != null) query['limit'] = limit;
      if (startAfter != null) query['startAfterDocument'] = startAfter;
      // fetch data
      List<Map<String, dynamic>> data = await db.getData(
        path: commentsPath,
        query: query,
      );
      List<CommentModel> comments = await // list to hold comment models
      // loop on data to overwrite author fields
      Future.wait(
        data.map((e) async {
          // author operation
          final author = await userRepo.getUserById(
            e[CommentFields.commentAuthorId],
          );
          author.fold((_) {}, (user) {
            e[CommentFields.commentAuthorName] = user.name;
            e[CommentFields.commentAuthorImage] = user.imageUrl;
            e[CommentFields.commentAuthorAccessLevel] = user.accessLevel;
          });
          // mentions operation
          final mentions = await userRepo.getUsersByIds(
            e[CommentFields.mentions],
          );
          mentions.fold(
            (l) => e[CommentFields.mentions] = [],
            (users) => e[CommentFields.mentions] = users,
          );
          // Replies Count operation
          final List<Map<String, dynamic>> replies = await db.getData(
            path:
                "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection/${e[CommentFields.commentId]}/$_commentsCollection",
          );
          final repliesCount = replies.length;
          e[CommentFields.repliesCount] = repliesCount; // add repliesCount key and its value
          return CommentModel.fromJson(e);
        }),
      );
      return Right(comments);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateComment({
    required CommentModel commentModel,
    required String commentId,
    required String postId,
    String? repledCommentId,
  }) async {
    try {
      final String path =
          repledCommentId == null
              ? "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection"
              : "${BackendEndpoints.postsCollection}/$postId/$_commentsCollection/$repledCommentId/$_commentsCollection";
      db.updateData(
        path: path,
        data: commentModel.toJson(),
        documentId: commentId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
