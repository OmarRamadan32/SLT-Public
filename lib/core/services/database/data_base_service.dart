abstract class DatabaseService {
  Future<void> addData({required String path, required Map<String, dynamic> data, String? documentId});
  Future<void> updateData({required String path, required Map<String, dynamic> data, required String documentId});
  Future<void> deleteData({required String path, String? documentId});
  Future<dynamic> getData({required  String path,  Map<String, dynamic>? query, String? docuementId});
  Future<bool> checkIfDataExists({required String path, required String docuementId});
}