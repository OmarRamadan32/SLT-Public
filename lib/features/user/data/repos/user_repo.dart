import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> getUserById(String id);
  Future<Either<Failure, List<UserModel>>> getUsersByIds(List<dynamic> ids);
  Future<UserModel> getCurrentUser(String uid);

  Future<Either<Failure, List<UserModel>>> getAllTeamUsers();

  Future<Either<Failure, List<UserModel>>> getUsersFromCollection({
    required String path,
    Map<String, dynamic>? where,
  });

  Future<Either<Failure, List<UserModel>>> getUsersFromField({
    required String path,
    required String fieldName,
    required String documentId,
  });

  Future<Either<Failure, List<UserModel>>> getNewUsers();

  Future<Either<Failure, void>> updateUsersAccessLevel({
    required List<String> usersIds,
    required int accessLevel,
    int? downgradeFrom,
     bool? downgrade,

  });
}
