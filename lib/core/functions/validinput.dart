import 'package:get/get_utils/get_utils.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "Champ vide".tr;
  }


  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Email non valide".tr;
    }
  }


}
