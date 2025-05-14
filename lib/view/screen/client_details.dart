import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/clientdetails_controller.dart';
import '../../core/constants/color.dart';
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

  // Helper method to get gender icon and text
  IconData _getGenderIcon(int idGender) {
    return idGender == 1
        ? Icons.male
        : (idGender == 2 ? Icons.female : Icons.person);
  }

  String _getGenderText(int idGender) {
    return idGender == 1 ? 'Homme' : (idGender == 2 ? 'Femme' : 'Autre');
  }

  Color _getStatusColor(bool isActive) {
    return isActive ? Colors.green : Colors.red;
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off, size: 80, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'Aucun client sélectionné',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight:
                  250, // Increased height to accommodate name underneath avatar
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '', // Empty title to remove the name from app bar title
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.primaryColor,
                            AppColor.primaryColor.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, // Position changed to place avatar higher
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(
                          children: [
                            Hero(
                              tag: 'clientAvatar${client.id}',
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    'assets/images/avatar.png',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${client.firstname} ${client.lastname}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatusItem(
                            icon: Icons.check_circle,
                            label: 'Statut',
                            value: client.active ? 'Actif' : 'Inactif',
                            color: _getStatusColor(client.active),
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildStatusItem(
                            icon: Icons.mail,
                            label: 'Newsletter',
                            value: client.newsletter ? 'Oui' : 'Non',
                            color:
                                client.newsletter ? Colors.green : Colors.grey,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildStatusItem(
                            icon: _getGenderIcon(client.idGender),
                            label: 'Genre',
                            value: _getGenderText(client.idGender),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Contact Information Section
                    _buildSectionTitle('Informations de Contact'),
                    _buildInfoCard([
                      _buildDetailItem(Icons.email, 'Email', client.email),
                      _buildDetailItem(
                        Icons.phone,
                        'Téléphone',
                        'Non disponible',
                        isAvailable: false,
                      ),
                      _buildDetailItem(
                        Icons.cake,
                        'Date de naissance',
                        formatDate(client.birthday),
                      ),
                    ]),

                    SizedBox(height: 20),

                    // Account Information Section
                    _buildSectionTitle('Informations du Compte'),
                    _buildInfoCard([
                      _buildDetailItem(
                        Icons.numbers,
                        'ID Client',
                        '#${client.id}',
                      ),
                      _buildDetailItem(
                        Icons.language,
                        'ID Langue',
                        '${client.idLang}',
                      ),
                      _buildDetailItem(
                        Icons.groups,
                        'Groupe par défaut',
                        '${client.idDefaultGroup}',
                      ),
                      _buildDetailItem(
                        Icons.group_work,
                        'Groupes',
                        client.groupIds.isEmpty
                            ? 'Aucun'
                            : client.groupIds.join(', '),
                      ),
                    ]),

                    SizedBox(height: 20),

                    // Shop Information
                    _buildSectionTitle('Informations Boutique'),
                    _buildInfoCard([
                      _buildDetailItem(
                        Icons.shopping_bag,
                        'ID Boutique',
                        '${client.idShop}',
                      ),
                      _buildDetailItem(
                        Icons.shopping_cart,
                        'Groupe Boutique',
                        '${client.idShopGroup}',
                      ),
                      _buildDetailItem(
                        Icons.person_add,
                        'Invité',
                        client.isGuest ? 'Oui' : 'Non',
                      ),
                    ]),

                    SizedBox(height: 20),

                    // Account Dates
                    _buildSectionTitle('Dates du Compte'),
                    _buildInfoCard([
                      _buildDetailItem(
                        Icons.date_range,
                        'Créé le',
                        DateFormat(
                          'd MMMM yyyy',
                          'fr_FR',
                        ).format(client.dateAdd),
                      ),
                      _buildDetailItem(
                        Icons.update,
                        'Dernière mise à jour',
                        DateFormat(
                          'd MMMM yyyy',
                          'fr_FR',
                        ).format(client.dateUpd),
                      ),
                    ]),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper methods for UI components
  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        SizedBox(height: 2),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value, {
    bool isAvailable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isAvailable
                      ? AppColor.primaryColor.withOpacity(0.1)
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isAvailable ? AppColor.primaryColor : Colors.grey,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isAvailable ? FontWeight.w500 : FontWeight.normal,
                  color: isAvailable ? Colors.black87 : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
