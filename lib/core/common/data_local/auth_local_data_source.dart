import 'dart:convert';

import 'package:mafuriko/core/common/models/user_model.dart';
import 'package:nb_utils/nb_utils.dart';

abstract interface class AuthLocalDataSource {
  Future<void> cacheUser(UserModel? user);
  Future<void> cacheToken(String? token);
  Future<UserModel?> getCachedUser();
  Future<String?> getCachedToken();
  Future<bool> clearCachedUser();
}

const cachedUser = 'CACHED_USER';
const token = 'TOKEN';

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
  Future<bool> clearCachedUser() async {
    return await sharedPreferences.remove(cachedUser);
  }

  @override
  Future<void> cacheToken(String? t) async {
    if (t != null && t.isNotEmpty) {
      await sharedPreferences.setString(token, t);
      log('Token cached successfully: $t');
    } else {
      log('Attempted to cache a null or empty token');
    }
  }

  @override
  Future<String?> getCachedToken() {
    final tokenCached = sharedPreferences.getString(token);
    // log('Fetching cached token: $tokenCached');

    if (tokenCached != null && tokenCached.isNotEmpty) {
      log('Cached token found: $tokenCached');
      return Future.value(tokenCached);
    } else {
      // log('No cached token found');
      return Future.value(null);
    }
  }
}
