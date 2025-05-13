import 'dart:convert'; // Pour base64Encode et utf8
import 'package:http/http.dart' as http;

// Vos informations de connexion
const String prestashopIp = 'localhost:8080'; // Votre IP et port
const String apiKey = '9G3RPXB51WTYMPFT95N6G7H3L9H2YRL6'; // Votre clé API

// L'URL de base de votre API PrestaShop (ajoutez /api/)
const String baseUrl = 'http://$prestashopIp/api';

Future<void> testPrestaShopConnection() async {
  // L'authentification Basic se fait avec "apiKey:" encodé en Base64
  // Le mot de passe est vide, donc on ajoute juste le ":" après la clé.
  String credentials = '$apiKey:';
  String encodedCredentials = base64.encode(utf8.encode(credentials));

  // Headers pour l'authentification et pour demander du JSON
  Map<String, String> headers = {
    'Authorization': 'Basic $encodedCredentials',
    'Accept': 'application/json', // Demander une réponse JSON
    'Output-Format': 'JSON' // Spécifique à PrestaShop pour s'assurer d'avoir du JSON
  };

  // Essayons d'accéder à une ressource simple, comme la liste des produits (limitée à 1 pour le test)
  // Ou juste '/' pour voir les ressources disponibles
  // String endpoint = '/products?display=full&limit=1';
  String endpoint = '/'; // Teste la connexion de base et liste les ressources disponibles

  var url = Uri.parse('$baseUrl$endpoint');

  try {
    print('Tentative de connexion à : $url');
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('-------------------------------------------');
      print('SUCCÈS : Connexion à PrestaShop réussie !');
      print('Statut de la réponse : ${response.statusCode}');
      print('Réponse du serveur (début) :');
      // Afficher les 500 premiers caractères de la réponse pour ne pas surcharger la console
      print(response.body.length > 500 ? response.body.substring(0, 500) + '...' : response.body);
      print('-------------------------------------------');

      // Vous pouvez parser le JSON ici si nécessaire
      // var jsonData = jsonDecode(response.body);
      // print(jsonData);

    } else {
      print('-------------------------------------------');
      print('ÉCHEC : Problème lors de la connexion à PrestaShop.');
      print('Statut de la réponse : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');
      print('-------------------------------------------');
    }
  } catch (e) {
    print('-------------------------------------------');
    print('ERREUR : Une exception est survenue lors de la tentative de connexion.');
    print('Exception : $e');
    print('-------------------------------------------');
    print('Vérifications possibles :');
    print('- Le serveur PrestaShop (10.245.149.64:8080) est-il en cours d\'exécution et accessible depuis votre machine/émulateur ?');
    print('- Le service web PrestaShop est-il activé dans le back-office ?');
    print('- La clé API ($apiKey) est-elle correcte, activée et a-t-elle les permissions nécessaires ?');
    print('- Un pare-feu bloque-t-il la connexion au port 8080 sur le serveur ?');
    print('- Si vous testez sur un appareil réel, est-il sur le même réseau que le serveur ou peut-il l\'atteindre ?');
  }
}