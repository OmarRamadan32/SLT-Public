import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    String finalDocId;
    if (documentId != null) {
      await db.collection(path).doc(documentId).set(data);
      await db.collection(path).doc(documentId).update({"id": documentId});
    } else {
      // this will create the document and save the id that generated in a field
      DocumentReference docRef = await db.collection(path).add(data);
      finalDocId = docRef.id;
      await docRef.update({'id': finalDocId});
    }
  }

  @override
  Future<void> deleteData({
    required String path,
    String? documentId,
  }) async {
    if (documentId != null) {
      await db.collection(path).doc(documentId).delete();
    } else {
      var collection = db.collection(path);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    Map<String, dynamic>? query,
    String? docuementId,
  }) async {
    if (docuementId != null) {
      var data = await db.collection(path).doc(docuementId).get();
      return data.data();
    } else {
      Query<Map<String, dynamic>> data = db.collection(path);

      if (query != null) {
        // where conditions
        if (query['where'] != null && query['where'] is List) {
          for (var condition in query['where']) {
            data = data.where(
              condition['field'],
              isEqualTo: condition['isEqualTo'],
              isGreaterThan: condition['isGreaterThan'],
              isLessThan: condition['isLessThan'],
              isGreaterThanOrEqualTo: condition['isGreaterThanOrEqualTo'],
              isLessThanOrEqualTo: condition['isLessThanOrEqualTo'],
              arrayContains: condition['arrayContains'],
              arrayContainsAny: condition['arrayContainsAny'],
              whereIn: condition['whereIn'],
              isNull: condition['isNull'],
            );
          }
        }

        // orderBy
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'] ?? false;
          data = data.orderBy(orderByField, descending: descending);
        }

        // limit
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }

        // pagination
        if (query['startAfterDocument'] != null) {
          var startAfter = query['startAfterDocument'];
          if (startAfter is String) {
            // treat the value as a document id — fetch its snapshot then start after it
            final docSnap = await db.collection(path).doc(startAfter).get();
            if (docSnap.exists) {
              data = data.startAfterDocument(docSnap);
            }
          } else if (startAfter is DocumentSnapshot) {
            // already a snapshot
            data = data.startAfterDocument(startAfter);
          }
        }
      }

      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await db.collection(path).doc(documentId).update(data);
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docuementId,
  }) async {
    var data = await db.collection(path).doc(docuementId).get();
    return data.exists;
  }
}
