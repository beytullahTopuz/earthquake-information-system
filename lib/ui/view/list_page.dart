import 'package:deperm_bilgi_sistemi/core/constants/string_functions.dart';
import 'package:deperm_bilgi_sistemi/core/services/api_service.dart';
import 'package:deperm_bilgi_sistemi/ui/view/detail_page.dart';
import 'package:deperm_bilgi_sistemi/ui/view/saved_list_page.dart';
import 'package:deperm_bilgi_sistemi/ui/viewModels/earthquake_controller.dart';
import 'package:deperm_bilgi_sistemi/ui/widgets/earthquakeListItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _ListPageState extends State<ListPage> {
  String _valueChoose = null;
  List listItem = [
    '2',
    '3',
    '4',
    '5',
  ];

  final EarthquakeController depremController =
      Get.find<EarthquakeController>();
  @override
  void initState() {
    depremController.filterList(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var test = depremController.depremList.length;
    print("list page, list size : " + test.toString());
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Text("Son Depremler",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            )),
        Expanded(flex: 9, child: _buildList()),
      ],
    );
  }

  DropdownButton<String> _buildBopdown() {
    return DropdownButton(
      hint: Text(
        "",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      dropdownColor: Color(0xff707070),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      iconSize: 40,
      value: _valueChoose,
      onChanged: (newValue) {
        setState(() {
          _valueChoose = newValue;
        });
        depremController.filterList(int.parse(_valueChoose));
      },
      items: listItem.map((valueitem) {
        return DropdownMenuItem(
          value: valueitem.toString(),
          child: Text(valueitem,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: AppBar(
            actions: [
              PopupMenuButton(
                icon: Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.black,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SavedListPage(),
                            ));
                          },
                          child: Text("Kayıtlı Depremler")),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: InkWell(
                          onTap: () {
                            getEathquake();
                          },
                          child: Text("Güncelle")),
                    ),
                  ];
                },
              ),
            ],
            backgroundColor: Color(0xffFFD64D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
            ),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        "Minimum Büyüklük",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      _buildBopdown(),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _buildList() {
    return Obx(() => ListView.builder(
          itemCount: depremController.filteredList.length,
          itemBuilder: (context, index) {
            var model = depremController.filteredList[index];

            var value = StringFunctions().titleSpiltting(model.title);

            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(
                    earthquake_model: depremController.filteredList[index],
                  ),
                ));
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: EarthquakeListItem(context: context, value: value)),
            );
          },
        ));
  }

  Future<void> getEathquake() async {
    var result = await APIservice().getAPI();
    depremController.addDeprem(result);
  }
}
