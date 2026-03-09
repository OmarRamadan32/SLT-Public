import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_slt/core/errors/failure.dart';

class ServerFailure extends Failure {

  const ServerFailure({required String message}) : super(message);

  factory ServerFailure.fromException(Object e) {
    if (e is FirebaseAuthException) {
      return ServerFailure(message: _mapFirebaseAuthError(e.code),);
    } else if (e is FirebaseException) {
      return ServerFailure(message: _mapFirebaseError(e.code),);
    }
    return const ServerFailure(message: 'حدث خطأ غير متوقع',);
  }

  static String _mapFirebaseError(String code) {
    switch (code) {
      case 'permission-denied':
        return 'ليس لديك صلاحية للوصول إلى البيانات.';
      case 'unavailable':
        return 'الخدمة غير متاحة حاليًا. حاول لاحقًا.';
      case 'not-found':
        return 'العنصر المطلوب غير موجود.';
      case 'unauthenticated':
        return 'يجب تسجيل الدخول أولاً.';
        case 'resource-exhausted':
        return 'تم استهلاك كافة الموارد المتاحه من الخدمة, سيتم إعادة التشغيل غدا';
      case 'deadline-exceeded':
        return 'انتهى الوقت المسموح للطلب.';
      default:
        return 'حدث خطأ غير متوقع: $code';
    }
  }
  static String _mapFirebaseAuthError(String code){
    switch (code) {
      case 'user-not-found':
        return 'المستخدم غير موجود.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.';
      case 'invalid-email':
        return 'البريد الالكتروني غير صالح.';
      case 'email-already-in-use':
        return 'البريد الالكتروني مستخدم بالفعل.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة.';
      case 'invalid-credential':
        return 'البيانات المدخلة غير صالحة.';
      default:
        return 'حدث خطاء غير متوقع: $code';
    }
  }
}