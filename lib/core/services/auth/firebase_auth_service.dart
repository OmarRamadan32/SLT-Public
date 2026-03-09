import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/auth/auth_service.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseService db;
  final NotificationService notificationService;
  FirebaseAuthService({required this.db, required this.notificationService});

  @override
  Future<Either<Failure, void>> createUserWithEmailAndPassword(
    String email,
    String password,
    UserModel userModel,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return const Left(ServerFailure(message: 'User creation failed.'));
      }

      await db.addData(
        path: BackendEndpoints.usersCollection,
        documentId: user.uid,
        data: userModel.toJson(),
      );
   await   notificationService.saveTokenToDatabase();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await  notificationService.saveTokenToDatabase();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final User? user = firebaseAuth.currentUser;
    if (user != null) {
      bool userDocument = await db.checkIfDataExists(
        path: BackendEndpoints.usersCollection,
        docuementId: user.uid,
      );
      return userDocument;
    } else {
      return false;
    }
  }

  @override
  String? getCurrentUserId() {
    final user = firebaseAuth.currentUser;
    return user!.uid;
  }
}
