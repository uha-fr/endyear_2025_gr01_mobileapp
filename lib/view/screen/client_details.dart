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
        
      ); 
    });
  }
}
