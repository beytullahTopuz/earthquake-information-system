import 'package:deperm_bilgi_sistemi/ui/viewModels/saved_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedListPage extends StatelessWidget {
  final savedListController = Get.find<SavedListController>();

  @override
  Widget build(BuildContext context) {
    //  savedListController.getDeprems();
    return Scaffold(
      backgroundColor: Color(0xffFFD64D),
      appBar: _buildAppBar(),
      body: Obx(() => ListView.builder(
            itemCount: savedListController.depremList.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(savedListController.depremList[index].title),
                    subtitle: Text(savedListController.depremList[index].pubDate
                        .toString()),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color(0xffFFD64D),
                      ),
                      onPressed: () {
                        savedListController.deleteDeprem(
                            savedListController.depremList[index]);
                      },
                    ),
                  ));
            },
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffFFD64D),
      title: Text(
        "Kayıtlı Depremler...",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
