import 'package:flutter/material.dart';
import '../../../data/datasource/models/client_model.dart';
import 'package:intl/intl.dart';

class CustomClientCard extends StatelessWidget {
  final Customer client;
  final VoidCallback onTap;

  const CustomClientCard({
    super.key,
    required this.client,
    required this.onTap,
  });

  String formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Icon(
            client.gender == 'Homme'
                ? Icons.man
                : client.gender == 'Femme'
                ? Icons.woman
                : Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text('${client.firstname} ${client.lastname}'),
        subtitle: Text('Crée: ${client.dateAdd}'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
