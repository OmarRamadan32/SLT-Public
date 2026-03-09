import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/posts/data/models/comment_model.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';

abstract class PostsRepo{ 
  
  Future<Either<Failure, void>> addPost({required PostModel postModel});
  
  Future<Either<Failure, void>> deletePost({required String postId});
  
  Future<Either<Failure, void>> updatePost({required String postId, required PostModel postModel});

  Future<Either<Failure, PostModel>> getPostById({required String postId});

  Future<Either<Failure, List<PostModel>>> getAllUserPosts({required String userId,
  int? limit,
  dynamic startAfter,
  });

  Future<Either<Failure, List<PostModel>>> getAllPosts({
      int? limit,
      dynamic startAfter,
    });

    Future<Either<Failure, List<PostModel>>> getApprovedPosts(
      {    int? limit,
    dynamic startAfter,}
    );

    Future<Either<Failure, List<PostModel>>> getPendingPosts({
      int? limit,
      dynamic startAfter,
    });

    Future<Either<Failure, void>> approvePost({required String postId,
    required String postAuthorId});

  Future<Either<Failure, void>> signPost({required String postId,required String userId});
  // --- Comments
  Future<Either<Failure, List<CommentModel>>> getComments({required String postId,
   int? limit,
   dynamic startAfter,
   String? commentId,
  }); 

  Future<Either<Failure, void>> addComment({required CommentModel commentModel,required String postId,
  required String postAuthorId,
  String? commentId,
      String? commentAuthorId,
  });

  Future<Either<Failure, void>> deleteComment({required String commentId,required String postId,
    String? repledCommentId,
  });
  Future<Either<Failure, void>> updateComment({required CommentModel commentModel,required String commentId,required String postId,
      String? repledCommentId,
  });
  
}