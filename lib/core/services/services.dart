import 'dart:convert'; // Pour base64Encode et utf8
import 'package:http/http.dart' as http;

Future<void> fetchFromPythonApi() async {
  var url = Uri.parse('http://localhost/xampp/check_prestashop.php'); // 10.0.2.2 = localhost Android emulator

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        print('✔️ Réussi : ${data['message']}');
        final responseStr = data['response'].toString();
final displayStr = responseStr.length > 200 ? responseStr.substring(0, 200) : responseStr;
print('🔄 Données : $displayStr...');

      } else {
        print('❌ Échec : ${data['message']}');
      }
    } else {
      print('❌ Erreur HTTP : ${response.statusCode}');
    }
  } catch (e) {
    print('⚠️ Exception : $e');
  }
}
