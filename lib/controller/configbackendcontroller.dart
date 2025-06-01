import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigBackendController extends GetxController {
  static const String _serverUrlKey = '';

  var serverUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadServerUrl();
  }

  Future<void> loadServerUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    serverUrl.value = prefs.getString(_serverUrlKey) ?? '';
    print("Loaded serverUrl: ${serverUrl.value}");
  }

  Future<void> saveServerUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_serverUrlKey, url);
    serverUrl.value = url;
  }
}
