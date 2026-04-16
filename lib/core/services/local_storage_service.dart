import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/core/constants/app_constants.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> saveUserSession(String uid, String role) async {
    await _prefs.setString(AppConstants.userIdKey, uid);
    await _prefs.setString(AppConstants.userRoleKey, role);
  }

  String? getUserId() => _prefs.getString(AppConstants.userIdKey);

  Future<void> clearSession() async {
    await _prefs.remove(AppConstants.userIdKey);
    await _prefs.remove(AppConstants.userRoleKey);
  }
}
