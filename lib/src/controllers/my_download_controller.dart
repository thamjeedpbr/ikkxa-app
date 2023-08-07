import 'package:get/get.dart';
import 'package:saudi_adaminnovations/src/models/my_download_model.dart';
import 'package:saudi_adaminnovations/src/servers/repository.dart';

class MyDownloadController extends GetxController {
  late Rx<MyDownloadModel> myDownloadModel = MyDownloadModel().obs;

  Future getMyDownload() async {
    await Repository().getMyDownload().then((value) {
      myDownloadModel.value = value!;
    });
    update();
  }

  @override
  void onInit() {
    getMyDownload();
    super.onInit();
  }
}
