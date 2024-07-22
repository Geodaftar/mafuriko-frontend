import 'dart:convert';

import 'package:mafuriko/features/authentication/data/models/user_model.dart';
import 'package:nb_utils/nb_utils.dart';

abstract interface class AuthLocalDataSource {
  Future<void> cacheUser(UserModel? user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCachedUser();
}

const cachedUser = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel? user) {
    return sharedPreferences.setString(cachedUser, user!.toJson());
  }

  @override
  Future<UserModel?> getCachedUser() {
    final jsonString = sharedPreferences.getString(cachedUser);
    log('value before　check :::::::::: $jsonString');
    if (jsonString != null) {
      log('user value :::::::::: ${UserModel.fromJson(json.decode(jsonString)).toJson()}');
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<void> clearCachedUser() {
    return sharedPreferences.remove(cachedUser);
  }
}
