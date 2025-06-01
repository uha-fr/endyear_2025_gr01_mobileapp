import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/statistics_model.dart';

class StatisticsData {
  final Crud crud;
  StatisticsData(this.crud);

  Future<StatisticsModel?> getData() async {
var response = await crud.getData(LinkApi.instance.statistics);
    return response.fold((l) {
      return null;
    }, (r) {
      if (r['success'] == true) {
        return StatisticsModel.fromJson(Map<String, dynamic>.from(r));
      } else {
        return null;
      }
    });
  }
}
