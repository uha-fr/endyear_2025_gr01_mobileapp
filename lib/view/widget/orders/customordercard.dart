import 'package:flutter/material.dart';

class CustomOrderCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String date;
  final double amount;
  final String status;

  const CustomOrderCard({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.date,
    required this.amount,
    required this.status,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'en attente du paiement par chèque':
        return Colors.orange.shade100;
      case 'paiement accepté':
        return Colors.green.shade100;
      case 'en cours de préparation':
        return Colors.blue.shade100;
      case 'expédié':
        return Colors.lightBlue.shade100;
      case 'livré':
        return Colors.green.shade200;
      case 'annulé':
        return Colors.red.shade100;
      case 'remboursé':
        return Colors.purple.shade100;
      case 'erreur de paiement':
        return Colors.red.shade300;
      case 'en attente de réapprovisionnement (payé)':
        return Colors.yellow.shade100;
      case 'en attente de virement bancaire':
        return Colors.orange.shade200;
      case 'paiement à distance accepté':
        return Colors.green.shade300;
      case 'en attente de réapprovisionnement (non payé)':
        return Colors.yellow.shade200;
      case 'en attente de paiement à la livraison':
        return Colors.orange.shade300;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'en attente du paiement par chèque':
        return Colors.orange;
      case 'paiement accepté':
        return Colors.green;
      case 'en cours de préparation':
        return Colors.blue;
      case 'expédié':
        return Colors.lightBlue;
      case 'livré':
        return Colors.green.shade700;
      case 'annulé':
        return Colors.red;
      case 'remboursé':
        return Colors.purple;
      case 'erreur de paiement':
        return Colors.red.shade700;
      case 'en attente de réapprovisionnement (payé)':
        return Colors.yellow.shade800;
      case 'en attente de virement bancaire':
        return Colors.orange.shade800;
      case 'paiement à distance accepté':
        return Colors.green.shade800;
      case 'en attente de réapprovisionnement (non payé)':
        return Colors.yellow.shade900;
      case 'en attente de paiement à la livraison':
        return Colors.orange.shade900;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.receipt_long, size: 36, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#$orderId",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(customerName, style: const TextStyle(fontSize: 14)),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${amount.toStringAsFixed(2)} €",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: _getTextColor(status),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
