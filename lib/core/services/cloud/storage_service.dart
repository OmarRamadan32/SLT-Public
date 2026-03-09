import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';

abstract class StorageService {
  Future<Either<Failure, String>> uploadFile(String path,String folderName);
  // Future<void> deleteFile(String path, String fileName);
  
}