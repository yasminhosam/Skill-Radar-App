import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_service.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/profile/data/repo/user_repo.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../networking/dio_factory.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Networking
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  // Firebase Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<FirebaseAuth>()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthService>(),getIt<UserRepo>()));

  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<UserRepo>(() => UserRepo(getIt<FirebaseFirestore>()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<UserRepo>()));
}
