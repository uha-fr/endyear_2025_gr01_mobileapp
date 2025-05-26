import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final StatisticsController statisticsController = Get.put(StatisticsController());

  Widget _buildStatCard(String title, Widget content) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueTrends(Map<String, Map<String, double>> trends) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quotidien", style: TextStyle(fontWeight: FontWeight.bold)),
        ...trends['quotidien']!.entries.map((e) => Text("${e.key}: ${e.value.toStringAsFixed(2)} €")),
        const SizedBox(height: 8),
        const Text("Mensuel", style: TextStyle(fontWeight: FontWeight.bold)),
        ...trends['mensuel']!.entries.map((e) => Text("${e.key}: ${e.value.toStringAsFixed(2)} €")),
      ],
    );
  }

  Widget _buildBestProducts(List bestProducts) {
    return Column(
      children: bestProducts.map((product) {
        return ListTile(
          title: Text(product.name),
          subtitle: Text("Quantity: ${product.quantity} - Revenue: ${product.revenue.toStringAsFixed(2)} €"),
        );
      }).toList(),
    );
  }

  Widget _buildOrderStatusConversion(List conversions) {
    return Column(
      children: conversions.map((conv) {
        return ListTile(
          title: Text(conv.nomStatut),
          trailing: Text(conv.nombreCommandes.toString()),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(""),
        centerTitle: true,
      ),
      body: Obx(() {
        final stats = statisticsController.statistics.value;
        if (stats == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 150,
                        child: _buildStatCard(
                          "Revenu Total",
                          Center(
                            child: Text("${stats.revenuTotal.toStringAsFixed(2)} €",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 150,
                        child: _buildStatCard(
                          "Valeur Moyenne Commande",
                          Center(
                            child: Text("${stats.valeurMoyenneCommande.toStringAsFixed(2)} €",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: _buildStatCard(
                          "Tendances Revenu",
                          _buildRevenueTrends(stats.tendancesRevenu),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: _buildStatCard(
                          "Acquisition Clients",
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: stats.acquisitionClients.entries
                                .map((e) => Text("${e.key}: ${e.value}"))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildStatCard(
                  "Meilleurs Produits",
                  _buildBestProducts(stats.meilleursProduits),
                ),
                _buildStatCard(
                  "Conversion Commandes par Statut",
                  _buildOrderStatusConversion(stats.conversionCommandesParStatut),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
