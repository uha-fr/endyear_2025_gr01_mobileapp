class TaskModel {
  String? idTache;
  String? titreTache;
  String? descriptionTache;
  String? statutTache;
  String? prioriteTache;
  String? dateEcheance;
  String? dateCreation;
  String? assigneA;
  String? categorieTache;

  TaskModel({
    this.idTache,
    this.titreTache,
    this.descriptionTache,
    this.statutTache,
    this.prioriteTache,
    this.dateEcheance,
    this.dateCreation,
    this.assigneA,
    this.categorieTache,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    idTache = json['id_tache'];
    titreTache = json['titre_tache'];
    descriptionTache = json['description_tache'];
    statutTache = json['statut_tache'];
    prioriteTache = json['priorite_tache'];
    dateEcheance = json['date_echeance'];
    dateCreation = json['date_creation'];
    assigneA = json['assigne_a'];
    categorieTache = json['categorie_tache'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tache'] = idTache;
    data['titre_tache'] = titreTache;
    data['description_tache'] = descriptionTache;
    data['statut_tache'] = statutTache;
    data['priorite_tache'] = prioriteTache;
    data['date_echeance'] = dateEcheance;
    data['date_creation'] = dateCreation;
    data['assigne_a'] = assigneA;
    data['categorie_tache'] = categorieTache;
    return data;
  }
}
