import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/imageassets.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ?  Center(child: Lottie.asset(AppImageAsset.loading,width: 250,height: 250 ),)
        : statusRequest == StatusRequest.offlinefailure
        ?  Center(child: Lottie.asset(AppImageAsset.offline,width: 250,height: 250 ))
        : statusRequest == StatusRequest.serverfailure
        ?  Center(child: Lottie.asset(AppImageAsset.server,width: 250,height: 250 ))
        : statusRequest == StatusRequest.failure
        ?  Center(
        child: Lottie.asset(AppImageAsset.noData,width: 250,height: 250 ))
        : widget;
  }
}


class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ?  Center(child: Lottie.asset(AppImageAsset.loading,width: 250,height: 250 ),)
        : statusRequest == StatusRequest.offlinefailure
        ?  Center(child: Lottie.asset(AppImageAsset.offline,width: 250,height: 250 ))
        : statusRequest == StatusRequest.serverfailure
        ?  Center(child: Lottie.asset(AppImageAsset.server,width: 250,height: 250 ))
        : widget;
  }
}
