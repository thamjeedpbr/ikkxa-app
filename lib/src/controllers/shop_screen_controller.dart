import 'package:get/get.dart';
import 'package:saudi_adaminnovations/src/models/visit_shop_model.dart';
import 'package:saudi_adaminnovations/src/servers/repository.dart';
import 'package:saudi_adaminnovations/src/utils/constants.dart';

class ShopScreenController extends GetxController{
  Rx<VisitShopModel> visitShopModel = VisitShopModel().obs;

  var shopId = Get.parameters['shopId'];
  int page = 1;

  Future getVisitShop() async {
    printLog(shopId);
    visitShopModel.value = await Repository().getVisitShop(int.parse(shopId!));
  }

  @override
  void onInit() {
    getVisitShop();
    super.onInit();
  }

}