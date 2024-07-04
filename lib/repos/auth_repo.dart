import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, Unit>> loginUser(String email, String password);
  Future<Either<String, Unit>> registerUser(
      String email, String password, String userName, String phoneNumber);
}
