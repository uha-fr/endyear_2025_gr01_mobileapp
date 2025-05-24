import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/clientdetails_controller.dart';
import '../../../data/datasource/models/client_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ClientDetailsPage extends StatelessWidget {
  final ClientDetailsController controller = Get.put(ClientDetailsController());

  // Helper method to format date
  String formatDate(String dateStr) {
    if (dateStr.isEmpty) return 'Non disponible';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMMM yyyy', 'fr_FR').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  // Helper method to get gender text
  String _getGenderText(int idGender) {
    return idGender == 1 ? 'Homme' : (idGender == 2 ? 'Femme' : 'Autre');
  }

  @override
  Widget build(BuildContext context) {
    // Initialize French locale for date formatting
    initializeDateFormatting('fr_FR', null);

    return Obx(() {
      final client = controller.selectedClient.value;

      if (client == null) {
        return Scaffold(
          appBar: AppBar(title: Text('Détails du client')),
          body: Center(child: Text('Aucun client sélectionné')),
        );
      }

      return Scaffold(
        appBar: AppBar(title: Text('${client.firstname} ${client.lastname}')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info
              Text(
                'Informations de base:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Nom: ${client.firstname} ${client.lastname}'),
              Text('Email: ${client.email}'),
              Text('Genre: ${_getGenderText(client.idGender)}'),
              Text('Date de naissance: ${formatDate(client.birthday)}'),
              Text('Statut: ${client.active ? 'Actif' : 'Inactif'}'),
              Text('Newsletter: ${client.newsletter ? 'Oui' : 'Non'}'),

              SizedBox(height: 20),

              // Account Info
              Text(
                'Informations du compte:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('ID Client: ${client.id}'),
              Text('ID Langue: ${client.idLang}'),
              Text('Groupe par défaut: ${client.idDefaultGroup}'),
              Text(
                'Groupes: ${client.groupIds.isEmpty ? 'Aucun' : client.groupIds.join(', ')}',
              ),

              SizedBox(height: 20),

              // Shop Info
              Text(
                'Informations boutique:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('ID Boutique: ${client.idShop}'),
              Text('Groupe Boutique: ${client.idShopGroup}'),
              Text('Invité: ${client.isGuest ? 'Oui' : 'Non'}'),

              SizedBox(height: 20),

              // Dates
              Text(
                'Dates:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Créé le: ${DateFormat('d MMMM yyyy', 'fr_FR').format(client.dateAdd)}',
              ),
              Text(
                'Dernière mise à jour: ${DateFormat('d MMMM yyyy', 'fr_FR').format(client.dateUpd)}',
              ),
            ],
          ),
        ),
      );
    });
  }
}
