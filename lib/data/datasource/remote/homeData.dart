import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/statistics_model.dart';

class StatisticsData {
  final Crud crud;
  StatisticsData(this.crud);

  Future<StatisticsModel?> getData() async {
    print("StatisticsData: Starting getData call to API");
    var response = await crud.getData(LinkApi.statistics);
    print("StatisticsData: Received response from API");
return response.fold((l) {
      print("StatisticsData: Error in API call: $l");
      return null;
    }, (r) {
      if (r['success'] == true) {
        print("StatisticsData: API call success true");
        return StatisticsModel.fromJson(Map<String, dynamic>.from(r));
      } else {
        print("StatisticsData: API call success false");
        return null;
      }
    });
  }
}
