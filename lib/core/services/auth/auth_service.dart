import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';

abstract class AuthService {
  Future<Either<Failure, void>> createUserWithEmailAndPassword(
    String email,
    String password,
    UserModel userModel,
  );

  Future<Either<Failure, void>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  Future<Either<Failure, void>> sendEmailVerification();

  Future<bool> isLoggedIn();

  String? getCurrentUserId();
}
