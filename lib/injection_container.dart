import 'package:get_it/get_it.dart';
import 'package:gradproj/repos/auth_repo.dart';
import 'package:gradproj/repos/auth_repo_impl.dart';
// ignore: depend_on_referenced_packages
import 'package:internet_connection_checker/internet_connection_checker.dart';
// ignore: depend_on_referenced_packages
import 'core/network/network_info.dart';
import 'cubit/auth_cubit/login_cubit/login_cubit.dart';
import 'cubit/auth_cubit/register_cubit/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! features
  //Blocs
  sl.registerFactory(() => RegisterCubit(authRepo: sl(), networkInfo: sl()));
  sl.registerFactory(() => LoginCubit(authRepo: sl(), networkInfo: sl()));

  //use Cases
  // sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
  // Repository
    sl.registerLazySingleton<AuthRepo>(() => AuthRepoImplementation());
  //Data Sources
  // sl.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  // sl.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(client:  sl()));

//!core
  //network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));


//! External
// final sharedPreferences = await SharedPreferences.getInstance();
// sl.registerLazySingleton(() => sharedPreferences);
sl.registerLazySingleton(() => InternetConnectionChecker());
}