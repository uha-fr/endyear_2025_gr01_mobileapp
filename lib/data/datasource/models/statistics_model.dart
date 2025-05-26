class StatisticsModel {
  final bool success;
  final double revenuTotal;
  final Map<String, Map<String, double>> tendancesRevenu;
  final double valeurMoyenneCommande;
  final Map<String, int> acquisitionClients;
  final List<BestProduct> meilleursProduits;
  final double tauxClientsFideles;
  final List<OrderStatusConversion> conversionCommandesParStatut;

  StatisticsModel({
    required this.success,
    required this.revenuTotal,
    required this.tendancesRevenu,
    required this.valeurMoyenneCommande,
    required this.acquisitionClients,
    required this.meilleursProduits,
    required this.tauxClientsFideles,
    required this.conversionCommandesParStatut,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, double>> tendances = {};
    if (json['tendances_revenu'] != null) {
      json['tendances_revenu'].forEach((key, value) {
        tendances[key] = Map<String, double>.from(value);
      });
    }

    Map<String, int> acquisition = {};
    if (json['acquisition_clients'] != null) {
      acquisition = Map<String, int>.from(json['acquisition_clients']);
    }

    List<BestProduct> bestProducts = [];
    if (json['meilleurs_produits'] != null) {
      bestProducts = (json['meilleurs_produits'] as List)
          .map((e) => BestProduct.fromJson(e))
          .toList();
    }

    List<OrderStatusConversion> conversions = [];
    if (json['conversion_commandes_par_statut'] != null) {
      conversions = (json['conversion_commandes_par_statut'] as List)
          .map((e) => OrderStatusConversion.fromJson(e))
          .toList();
    }

    return StatisticsModel(
      success: json['success'] ?? false,
      revenuTotal: (json['revenu_total'] ?? 0).toDouble(),
      tendancesRevenu: tendances,
      valeurMoyenneCommande: (json['valeur_moyenne_commande'] ?? 0).toDouble(),
      acquisitionClients: acquisition,
      meilleursProduits: bestProducts,
      tauxClientsFideles: (json['taux_clients_fideles'] ?? 0).toDouble(),
      conversionCommandesParStatut: conversions,
    );
  }
}

class BestProduct {
  final int quantity;
  final double revenue;
  final String name;

  BestProduct({
    required this.quantity,
    required this.revenue,
    required this.name,
  });

  factory BestProduct.fromJson(Map<String, dynamic> json) {
    return BestProduct(
      quantity: json['quantity'] ?? 0,
      revenue: (json['revenue'] ?? 0).toDouble(),
      name: json['name'] ?? '',
    );
  }
}

class OrderStatusConversion {
  final int idStatut;
  final String nomStatut;
  final int nombreCommandes;

  OrderStatusConversion({
    required this.idStatut,
    required this.nomStatut,
    required this.nombreCommandes,
  });

  factory OrderStatusConversion.fromJson(Map<String, dynamic> json) {
    return OrderStatusConversion(
      idStatut: json['id_statut'] ?? 0,
      nomStatut: json['nom_statut'] ?? '',
      nombreCommandes: json['nombre_commandes'] ?? 0,
    );
  }
}
