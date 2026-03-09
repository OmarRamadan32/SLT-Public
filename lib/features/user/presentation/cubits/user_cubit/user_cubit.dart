import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/core/services/auth/auth_service.dart';
import 'package:new_slt/core/services/cloud/storage_service.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:path_provider/path_provider.dart';

part 'user_state.dart';

/*
! User Cubit is responsible for handling all user related business logic
! not just fetching users data
*/
class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.userRepo,
    required this.authService,
    required this.storageService,
  }) : super(UserInitial());
  StorageService storageService;
  UserRepo userRepo;
  AuthService authService;
  // current user model
  UserModel? userModel;
  // selected image
  File? imageFile;
  // selected images
  List<File> imageFiles = [];
  // images urls (after upload)
  List<String> imageUrls = [];
  // image url (after upload)
  String? imageUrl;
  // selected image two
  File? imageFileTwo;
  // image url two
  String? imageUrlTwo;
  // selected User (for choose single member page)
  UserModel? selectedUser;
  // Selected UserNumberTwo
  UserModel? selectedUserTwo;
  // selected UserThree
  UserModel? selectedUserThree;
  // selected Users (for choose members page)
  List<UserModel> selectedUsers = [];
  // users list (for choose members pages)
  List<UserModel> usersList = [];

  Future<void> pickImage([bool isSecondImage = false]) async {
    File? file = await Helpers.pickImageFromGallery();

    if (file != null) {
      if (isSecondImage) {
        imageFileTwo = await compressImage(file);
      } else {
        imageFile = await compressImage(file);
      }
      emit(UserImagePicked());
    }
  }

  Future<void> pickMultipleImages() async {
    List<File> files = await Helpers.pickMultipleImagesFromGallery();

    for (File file in files) {
      // 1. استخراج اسم الملف الأصلي (عشان ده البصمة الثابتة بتاعته)
      String fileName = file.path.split('/').last;

      // 2. فحص هل أي ملف في الـ imageFiles الحالية له نفس الاسم؟
      // بنقارن نصوص (Strings) مش Objects
      bool isDuplicate = imageFiles.any((f) => f.path.contains(fileName));

      if (!isDuplicate && imageFiles.length < 5) {
        // 3. لو مش مكررة، اضغطها وضيفها
        File? compressedFile = await compressImage(file);

        if (compressedFile != null) {
          imageFiles.add(compressedFile);
        }
      }
    }
    emit(UserImagePicked());
  }

  Future<void> excludeImage(File file) async {
    imageFiles.remove(file);
    emit(UserImagePicked());
  }

  // compress image
  Future<File?> compressImage(File file) async {
final tempDir = await getTemporaryDirectory();

// 1. استخراج اسم الملف بدون الامتداد القديم
// لو الصورة اسمها image.png، هناخد كلمة "image" بس
String fileNameNoExtension = file.path.split('/').last.split('.').first;

// 2. بناء الـ targetPath بامتداد .jpg إجباري طالما بنضغط لـ jpeg
final targetPath = '${tempDir.path}/$fileNameNoExtension.jpg';

final xfile = await FlutterImageCompress.compressAndGetFile(
  file.absolute.path,
  targetPath,
  quality: 50,
  minWidth: 800,
  minHeight: 800,
  format: CompressFormat.jpeg, // طالما دي jpeg لازم المسار فوق يكون آخره .jpg
);

    if (xfile == null) return null;
    return File(xfile.path);
  }

  Future<void> uploadImage({
    required String path,
    required String folderName,
    bool? isSecondImage,
  }) async {
    emit(UserLoadingState());
    var result = await storageService.uploadFile(path, folderName);
    result.fold(
      (failure) => emit(UserErrorState(errorMessage: failure.message)),
      (url) {
        if (isSecondImage == false || isSecondImage == null) {
          imageUrl = url;
        } else {
          imageUrlTwo = url;
        }
      },
    );
  }

  Future<void> uploadMultipleImages({required String folderName}) async {
    if (imageFiles.isEmpty) return;

    emit(UserLoadingState());

    List<String> sortedUrls = await Future.wait(
      imageFiles.map((file) async {
        var result = await storageService.uploadFile(file.path, folderName);
        return result.fold((failure) => '', (url) => url);
      }),
    );
    imageUrls.addAll(sortedUrls.where((url) => url.isNotEmpty));
  }

  // when the app starts
  Future<void> getCurrentUser() async {
    await userRepo.getCurrentUser(authService.getCurrentUserId()!).then((user) {
      userModel = user;
    });
  }

  // for updating choose members pages on change
  void updateUser() {
    emit(UserUpdatedState());
  }

  // for choose single members

  // for choose members pages
  void chooseUsers(List<UserModel> users) {
    selectedUsers = users;
    emit(UserSelectedState());
  }

  // for mentions
  void excludeUser(UserModel user) {
    selectedUsers.remove(user);
    emit(UserSelectedState());
  }

  // reset variables
  void reset() {
    imageFile = null;
    imageFiles = [];
    imageUrl = null;
    imageUrls = [];
    imageFileTwo = null;
    imageUrlTwo = null;
    selectedUser = null;
    selectedUserTwo = null;
    selectedUserThree = null;
    selectedUsers = [];
    emit(UserInitial());
  }

  // for choose Members Pages
  Future<void> getUsersFromCollection({
    required String path,
    Map<String, dynamic>? where,
  }) async {
    emit(UserLoadingState());
    var result = await userRepo.getUsersFromCollection(
      path: path,
      where: where,
    );
    result.fold(
      (failure) => emit(UserErrorState(errorMessage: failure.message)),
      (users) {
        usersList = users;
        emit(UserSuccessState());
      },
    );
  }

  // for choose Members Pages
  Future<void> getUsersFromField({
    required String path,
    required String documentId,
    required String fieldName,
  }) async {
    emit(UserLoadingState());
    var result = await userRepo.getUsersFromField(
      path: path,
      fieldName: fieldName,
      documentId: documentId,
    );
    result.fold(
      (l) {
        emit(UserErrorState(errorMessage: "حدث خطأ ما"));
      },
      (r) {
        usersList = r;
        emit(UserSuccessState());
      },
    );
  }

  // for profile page
  Future<void> getUserById(String usersId) async {
    emit(UserLoadingState());
    var result = await userRepo.getUserById(usersId);
    result.fold(
      (failure) => emit(UserErrorState(errorMessage: failure.message)),
      (user) => emit(UserLoadedState(userModel: user)),
    );
  }

  Future<void> getnewUsers() async {
    emit(UserLoadingState());
    var result = await userRepo.getNewUsers();
    result.fold(
      (failure) => emit(UserErrorState(errorMessage: failure.message)),
      (users) {
        usersList = users;
        emit(UserSuccessState());
      },
    );
  }

  int getUserAccessLevel() {
    return userModel!.accessLevel!;
  }

  bool isAdmin() {
    if (getUserAccessLevel() == Constants.adminAccessLevel) {
      return true;
    } else {
      return false;
    }
  }
}
