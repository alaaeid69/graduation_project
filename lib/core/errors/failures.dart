import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  // factory ServerFailure.fromDioException(DioException dioException) {
  //   switch (dioException.type) {
  //     case DioExceptionType.connectionTimeout:
  //       return ServerFailure('Connection time out with ApiServer');
  //     case DioExceptionType.sendTimeout:
  //       return ServerFailure('send timeout out with ApiServer');
  //     case DioExceptionType.receiveTimeout:
  //       return ServerFailure('receive time out with ApiServer');
  //     case DioExceptionType.badCertificate:
  //       return ServerFailure('bad certificate');
  //     case DioExceptionType.badResponse:
  //       return ServerFailure.fromResponse(
  //           dioException.response!.statusCode!, dioException.response!.data);
  //     case DioExceptionType.cancel:
  //       return ServerFailure('Request was canceled');
  //     case DioExceptionType.connectionError:
  //       return ServerFailure('No internet Connection');
  //     case DioExceptionType.unknown:
  //       return ServerFailure('Unexpected error, please try again later');
  //     default:
  //       return ServerFailure('Opps there was an error please try again');
  //   }
  // }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, please try later');
    } else {
      return ServerFailure('Opps there was an error please try again');
    }
  }
}



class FirebaseAuthExceptionHandler {
  static String handleException(FirebaseAuthException e,) {
    String errorMessage = 'An unexpected error occurred.';

    switch (e.code) {
      case 'user-not-found':
        errorMessage ='المستخدم غير موجود. يرجى التحقق من البريد الإلكتروني.' ;
        break;
      case 'wrong-password':
        errorMessage ='كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.';
        break;
      case 'email-already-in-use':
        errorMessage ='البريد الإلكتروني مستخدم بالفعل. يرجى استخدام بريد إلكتروني آخر.';
        break;
      case 'weak-password':
        errorMessage ='كلمة المرور ضعيفة جداً.';
        break;
    // Add more cases for other error codes as needed
      default:
        errorMessage ='حدث خطأ غير متوقع.';
    }

    return errorMessage;
  }
}

