import 'package:get/get.dart';
import '../data/datasource/models/statistics_model.dart';
import '../data/datasource/remote/homeData.dart';
import '../core/class/crud.dart';

class StatisticsController extends GetxController {
  var statistics = Rxn<StatisticsModel>();
  late StatisticsData statisticsData;

  @override
  void onInit() {
    super.onInit();
    statisticsData = StatisticsData(Crud());
    fetchStatistics();
  }

  void fetchStatistics() async {
    var data = await statisticsData.getData();
    if (data != null) {
      statistics.value = data;
    } else {
      print("StatisticsController: Failed to fetch statistics");
    }
  }
}
