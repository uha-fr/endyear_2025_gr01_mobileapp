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

  String _getGenderText(String? gender) {
    if (gender == null) return 'Autre';
    final g = gender.toLowerCase();
    if (g == 'homme' || g == 'male') return 'Homme';
    if (g == 'femme' || g == 'female') return 'Femme';
    return 'Autre';
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
        appBar: AppBar(title: Text('Détails du client')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                '${client.firstname} ${client.lastname}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Email: ${client.email.isNotEmpty ? client.email : 'Non disponible'}',
              ),
              SizedBox(height: 8),
              Text('Genre: ${_getGenderText(client.gender)}'),
              SizedBox(height: 8),
              Text('Date de naissance: ${client.birthday ?? 'Non disponible'}'),
              SizedBox(height: 8),
              Text('Actif: ${client.active == 1 ? 'Oui' : 'Non'}'),
              SizedBox(height: 8),
              Text('Date d\'ajout: ${formatDate(client.dateAdd)}'),
              SizedBox(height: 8),
              Text(
                'Date de mise à jour: ${client.dateUpd != null ? formatDate(client.dateUpd!) : 'Non disponible'}',
              ),
              SizedBox(height: 16),
              Text(
                'Historique des commandes:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Obx(() {
                if (controller.orderIds.isEmpty) {
                  return Text('Aucune commande trouvée.');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      controller.orderIds
                          .map((orderId) => Text('Commande ID: $orderId'))
                          .toList(),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
