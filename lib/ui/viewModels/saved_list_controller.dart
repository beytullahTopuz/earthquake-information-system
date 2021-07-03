import 'package:deperm_bilgi_sistemi/core/models/earthquake_model.dart';
import 'package:deperm_bilgi_sistemi/core/services/sqlite_service.dart';
import 'package:get/get.dart';

class SavedListController extends GetxController {
  var depremList = RxList<Earthquake_model>();

  addDeprem(Earthquake_model model) {
    try {
      SQliteService().insertItem(model);
      depremList.add(model);
    } catch (e) {
      print(e.code);
    }
  }

  getDeprems() async {
    depremList.addAll(await SQliteService().getList());
  }

  deleteDeprem(Earthquake_model model) {
    SQliteService().deleteItem(model.id);

    depremList.clear();
    getDeprems();
  }
}
