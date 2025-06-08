import 'package:endyear_2025_gr01_mobileapp/controller/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/clientdetails_controller.dart';
import '../../../data/datasource/models/client_model.dart';
import '../../core/constants/color.dart';
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
  String _getGenderText(String? gender) {
    if (gender == null) return 'Autre';
    final g = gender.toLowerCase();
    if (g == 'homme' || g == 'male') return 'Homme';
    if (g == 'femme' || g == 'female') return 'Femme';
    return 'Autre';
  }

  // Helper method to get gender icon
  IconData _getGenderIcon(String? gender) {
    final genderText = _getGenderText(gender);
    return genderText == 'Homme'
        ? Icons.man
        : genderText == 'Femme'
        ? Icons.woman
        : Icons.person;
  }

  // Helper method to calculate age
  String _calculateAge(String? birthday) {
    if (birthday == null || birthday.isEmpty) return 'Non disponible';
    try {
      final birthDate = DateTime.parse(birthday);
      final today = DateTime.now();
      final age = today.year - birthDate.year;
      final isBeforeBirthday =
          today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day);
      return '${isBeforeBirthday ? age - 1 : age} ans';
    } catch (e) {
      return 'Non disponible';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize French locale for date formatting
    initializeDateFormatting('fr_FR', null);

    return Obx(() {
      final client = controller.selectedClient.value;

      if (client == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Détails du client'),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColor.primaryColor),
                SizedBox(height: 16),
                Text(
                  'Chargement des détails...',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
              expandedHeight: 200,
              pinned: true,
              actions: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '${client.firstname} ${client.lastname}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            _getGenderIcon(client.gender),
                            size: 48,
                            color: AppColor.primaryColor,
                          ),
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
                    // Status and summary bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
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
                            icon:
                                client.active == 1
                                    ? Icons.check_circle
                                    : Icons.cancel,
                            label: 'Statut',
                            value: client.active == 1 ? 'Actif' : 'Inactif',
                            color:
                                client.active == 1 ? Colors.green : Colors.red,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildStatusItem(
                            icon: Icons.cake,
                            label: 'Âge',
                            value: _calculateAge(client.birthday),
                            color: Colors.blue,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildStatusItem(
                            icon: Icons.shopping_bag,
                            label: 'Commandes',
                            value: controller.orderIds.length.toString(),
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Client Information Section
                    _buildSectionTitle('Informations personnelles'),
                    _buildInfoCard([
                      _buildDetailItem(
                        Icons.person_outline,
                        'Nom complet',
                        '${client.firstname} ${client.lastname}',
                      ),
                      _buildDetailItem(
                        Icons.email_outlined,
                        'Email',
                        client.email.isNotEmpty
                            ? client.email
                            : 'Non disponible',
                        isAvailable: client.email.isNotEmpty,
                      ),
                      _buildDetailItem(
                        _getGenderIcon(client.gender),
                        'Genre',
                        _getGenderText(client.gender),
                      ),
                      _buildDetailItem(
                        Icons.cake_outlined,
                        'Date de naissance',
                        client.birthday ?? 'Non disponible',
                        isAvailable: client.birthday != null,
                      ),
                    ]),

                    SizedBox(height: 16),

                    // Account Information Section
                    _buildSectionTitle('Informations du compte'),
                    _buildInfoCard([
                      _buildDetailItem(
                        Icons.access_time,
                        'Date de création',
                        formatDate(client.dateAdd),
                      ),
                      _buildDetailItem(
                        Icons.update,
                        'Dernière mise à jour',
                        client.dateUpd != null
                            ? formatDate(client.dateUpd!)
                            : 'Non disponible',
                        isAvailable: client.dateUpd != null,
                      ),
                      _buildDetailItem(
                        client.active == 1 ? Icons.check_circle : Icons.cancel,
                        'Statut du compte',
                        client.active == 1 ? 'Actif' : 'Inactif',
                      ),
                    ]),

                    SizedBox(height: 20),

                    // Addresses Section
                    _buildSectionTitle(
                      'Adresses (${client.addresses?.length ?? 0})',
                    ),
                    if (client.addresses == null || client.addresses!.isEmpty)
                      Container(
                        padding: EdgeInsets.all(20),
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_off,
                              color: Colors.grey[400],
                              size: 24,
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Aucune adresse disponible',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (client.addresses != null &&
                        client.addresses!.isNotEmpty)
                      Container(
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
                        child: Column(
                          children:
                              client.addresses!.asMap().entries.map((entry) {
                                int index = entry.key;
                                var address = entry.value;
                                bool isLast =
                                    index == client.addresses!.length - 1;

                                return Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.location_on,
                                              color: AppColor.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${address.address1}${address.address2 != null && address.address2!.isNotEmpty ? ', ${address.address2}' : ''}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  '${address.postcode} ${address.city}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  '${address.country}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                if (address.phone.isNotEmpty)
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        size: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        address.phone,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (!isLast)
                                        Divider(
                                          height: 16,
                                          color: Colors.grey[200],
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),

                    SizedBox(height: 20),

                    // Orders Section
                    _buildSectionTitle(
                      'Historique des commandes (${controller.orderIds.length})',
                    ),
                    Obx(() {
                      if (controller.orderIds.isEmpty) {
                        return Container(
                          padding: EdgeInsets.all(20),
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.grey[400],
                                size: 24,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Aucune commande trouvée',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

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
                        child: Column(
                          children:
                              controller.orderIds.asMap().entries.map((entry) {
                                int index = entry.key;
                                int orderId = entry.value;
                                bool isLast =
                                    index == controller.orderIds.length - 1;

                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      '/orderdetails',
                                      arguments: orderId,
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: AppColor.primaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.receipt_long,
                                                color: AppColor.primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Commande #$orderId',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'Voir les détails',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14,
                                              color: Colors.grey[400],
                                            ),
                                          ],
                                        ),
                                        if (!isLast)
                                          Divider(
                                            height: 16,
                                            color: Colors.grey[200],
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    }),

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
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
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
          Expanded(
            child: Column(
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
                    fontWeight:
                        isAvailable ? FontWeight.w500 : FontWeight.normal,
                    color: isAvailable ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
