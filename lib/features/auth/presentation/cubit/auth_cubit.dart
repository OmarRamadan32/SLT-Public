import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/services/auth/auth_service.dart';
import 'package:new_slt/core/services/cloud/storage_service.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/features/auth/data/models/login_model.dart';
import 'package:new_slt/features/auth/data/models/register_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final DatabaseService db;
  final AuthService auth;
  final StorageService storage;

  AuthCubit({required this.db, required this.auth, required this.storage})
    : super(AuthInitialState());
  RegisterModel registerModel = RegisterModel();
  LoginModel loginModel = LoginModel();
  UserModel userModel = UserModel(
    imageUrl: '',
    bio: "قم بوضع نبذة عنك",
    accountType: Constants.guestMember,
    token: '',
    name: '',
    title: 'عضو',
    councilNumber: 0,
    groupNumber: 0,
    isMainBOD: false,
    isSubBOD: false,
    accessLevel: 0,
  );

  void setCouncilNumber(int number) {
    userModel.councilNumber = number;
    emit(AuthDetailChangeState());
  }

  void setGroupNumber(int number) {
    userModel.groupNumber = number;
    emit(AuthDetailChangeState());
  }

  void setTitle(String title) {
    userModel.title = title;
    emit(AuthDetailChangeState());
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    var result = await auth.signInWithEmailAndPassword(email, password);
    result.fold(
      (Failure fail) => emit(AuthErrorState(errorMessage: fail.message)),
      (value) => emit(AuthSuccessState()),
    );
  }

  Future<void> register(
    String email,
    String password,
    UserModel userModel,
  ) async {
    emit(AuthLoadingState());
    var result = await auth.createUserWithEmailAndPassword(
      email,
      password,
      userModel,
    );
    result.fold(
      (Failure fail) => emit(AuthErrorState(errorMessage: fail.message)),
      (value) => emit(AuthSuccessState()),
    );
  }

  Future<void> uploadImage(String path) async {
    emit(AuthLoadingState());
    var result = await storage.uploadFile(path, BackendEndpoints.usersFolder);
    result.fold(
      (Failure fail) => emit(AuthErrorState(errorMessage: fail.message)),
      (value) {
        userModel.imageUrl = value;
      },
    );
  }

  Future<void> logout() async {
    var result = await auth.signOut();

    result.fold(
      (Failure fail) => emit(AuthErrorState(errorMessage: fail.message)),
      (value) {},
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(AuthLoadingState());
    var result = await auth.sendPasswordResetEmail(email);
    result.fold(
      (Failure fail) => emit(AuthErrorState(errorMessage: fail.message)),
      (value) => emit(PasswordChangeState()),
    );
  }

  Future<void> sendEmailVerification() async {
    emit(AuthLoadingState());
    var result = await auth.sendEmailVerification();
    result.fold(
      (Failure fail) => emit(AuthErrorState(errorMessage: fail.message)),
      (value) => emit(AuthSuccessState()),
    );
  }

  Future<bool> isLoggedIn() async => await auth.isLoggedIn();
  String? getCurrentUserId() => auth.getCurrentUserId();
}
