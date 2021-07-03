import 'package:deperm_bilgi_sistemi/core/constants/string_functions.dart';
import 'package:deperm_bilgi_sistemi/core/models/earthquake_model.dart';
import 'package:get/get.dart';

class EarthquakeController extends GetxController {
  var depremList = RxList<Earthquake_model>();
  var filteredList = RxList<Earthquake_model>();

  addDeprem(List<Earthquake_model> earthquakeModelList) {
    depremList.addAll(earthquakeModelList);
  }

  filterList(int value) {
    if (value == null) {
      filteredList.clear();
      filteredList.addAll(depremList);
    } else {
      filteredList.clear();
      depremList.forEach((element) {
        if (double.parse(
                StringFunctions().titleSpiltting(element.title)['buyukluk']) >=
            value) {
          filteredList.add(element);
        }
      });
    }
  }
}
