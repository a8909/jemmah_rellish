import 'package:shared_preferences/shared_preferences.dart';

class Localstorage {
  Future create({required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  updating({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(key) ?? 'users login are empty';
  }

  Future remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<bool> savepostUpdate(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final upd = await prefs.setStringList(key, value);
    return upd;
  }

  Future<List<String>?> getPost(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  getData(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(key);
  }

  Future switching(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  getSwitch(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(key);
  }

  saveTooltip({required String key, required int value}) async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    await db.setInt(key, value);
  }

  Future<int?> savedTooltips(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
}
