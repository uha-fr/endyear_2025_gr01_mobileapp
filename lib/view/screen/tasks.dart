import 'package:endyear_2025_gr01_mobileapp/controller/tasks_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/handlingdataview.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/customappbarSearch.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/tasks/customlisttasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    TasksControllerImp controller = Get.put(TasksControllerImp());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            CustomAppBarSearsh(
              mycontroller: TextEditingController(),
              onChanged: (val) {},
              title: "Nom de la tâche",
              onPressedIcon: () {},
              onPressedSearch: () {},
            ),
            const SizedBox(height: 20),
            GetBuilder<TasksControllerImp>(
              builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    // Filters UI (can be expanded later)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: controller.selectedStatusFilter,
                          hint: Text('Filtrer par statut'),
                          items: controller.statusFilters
                              .map((status) => DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.changeStatusFilter(value);
                            }
                          },
                        ),
                        DropdownButton<String>(
                          value: controller.selectedPriorityFilter,
                          hint: Text('Filtrer par priorité'),
                          items: controller.priorityFilters
                              .map((priority) => DropdownMenuItem<String>(
                                    value: priority,
                                    child: Text(priority),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.changePriorityFilter(value);
                            }
                          },
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.filteredData.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.7),
                      itemBuilder: (BuildContext context, index) {
                        return CustomListTasks(taskModel: controller.filteredData[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
