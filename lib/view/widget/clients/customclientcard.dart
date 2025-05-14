import 'package:flutter/material.dart';
import '../../../data/datasource/models/client_model.dart';

class CustomClientCard extends StatelessWidget {
  final Customer client;
  final VoidCallback onTap;

  const CustomClientCard({Key? key, required this.client, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        title: Text('${client.firstname} ${client.lastname}'),
        subtitle: Text(client.email),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
