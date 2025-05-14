import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/taskmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/tasksData.dart';
import 'package:get/get.dart';

abstract class TasksController extends GetxController {
  intialData();
  changeStatusFilter(String status);
  changePriorityFilter(String priority);
  getTasks();
  goToPageTaskDetails(TaskModel taskModel);
}

class TasksControllerImp extends TasksController {
  List<String> statusFilters = ['Tous', 'Ouvert', 'En cours', 'Terminé'];
  List<String> priorityFilters = ['Tous', 'Haute', 'Moyenne', 'Basse'];

  String selectedStatusFilter = 'Tous';
  String selectedPriorityFilter = 'Tous';

  late TasksData tasksData = TasksData();

  List data = [];
  List filteredData = [];

  late StatusRequest statusRequest;

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    getTasks();
  }

  @override
  void changeStatusFilter(String status) {
    selectedStatusFilter = status;
    applyFilters();
  }

  @override
  void changePriorityFilter(String priority) {
    selectedPriorityFilter = priority;
    applyFilters();
  }

  void applyFilters() {
    filteredData = data.where((task) {
      final statusMatch = selectedStatusFilter == 'Tous' || task.statutTache == selectedStatusFilter;
      final priorityMatch = selectedPriorityFilter == 'Tous' || task.prioriteTache == selectedPriorityFilter;
      return statusMatch && priorityMatch;
    }).toList();
    update();
  }

  @override
  getTasks() async {
    // For now, mock data similar to products
    data = [
      TaskModel(
        idTache: "1",
        titreTache: "Tâche 1",
        descriptionTache: "Description de la tâche 1",
        statutTache: "Ouvert",
        prioriteTache: "Haute",
        dateEcheance: "2023-12-01",
        dateCreation: "2023-01-01",
        assigneA: "Utilisateur A",
        categorieTache: "Catégorie 1",
      ),
      TaskModel(
        idTache: "2",
        titreTache: "Tâche 2",
        descriptionTache: "Description de la tâche 2",
        statutTache: "En cours",
        prioriteTache: "Moyenne",
        dateEcheance: "2023-12-15",
        dateCreation: "2023-01-05",
        assigneA: "Utilisateur B",
        categorieTache: "Catégorie 2",
      ),
      TaskModel(
        idTache: "3",
        titreTache: "Tâche 3",
        descriptionTache: "Description de la tâche 3",
        statutTache: "Terminé",
        prioriteTache: "Basse",
        dateEcheance: "2023-11-30",
        dateCreation: "2023-01-10",
        assigneA: "Utilisateur C",
        categorieTache: "Catégorie 1",
      ),
    ];
    statusRequest = StatusRequest.success;
    applyFilters();
  }

  @override
  goToPageTaskDetails(taskModel) {
    Get.toNamed("taskdetails", arguments: {"taskModel": taskModel});
  }
}
