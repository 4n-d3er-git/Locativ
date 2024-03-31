import 'package:get/get.dart';
import 'package:locative/ui/widgets/connexion/connexion.dart';


class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}