import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';

//Pour verifier si la reponse est de type StatusRequest ou pas
handlingData(response){
  if( response is StatusRequest){
    return response;
  }else{
    return StatusRequest.success;
  }
}