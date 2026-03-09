import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/cloud/storage_service.dart';

class CloudinaryService implements StorageService {
  @override
  Future<Either<Failure, String>> uploadFile(
    String path,
    String folderName,
  ) async {
    final Dio dio = Dio();
    const String cloudName = 'dxhb7vz07';
    const String uploadPreset = 'SLT_STORAGE';
    final String uploadUrl =
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
    try {
      final response = await dio.post(
        uploadUrl,
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(path),
          'upload_preset': uploadPreset,
          'folder': folderName,
        }),
      );

      final imageUrl = response.data['secure_url'] as String;
      return Right(imageUrl);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
