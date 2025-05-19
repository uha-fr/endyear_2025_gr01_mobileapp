import 'dart:convert'; // Pour base64Encode et utf8
import 'package:http/http.dart' as http;

Future<void> fetchFromPythonApi() async {
  var url = Uri.parse('http://10.0.2.2:5000/check_prestashop'); // 10.0.2.2 = localhost Android emulator

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        print('✔️ Réussi : ${data['message']}');
        print('🔄 Données : ${data['data'].toString().substring(0, 200)}...');
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
