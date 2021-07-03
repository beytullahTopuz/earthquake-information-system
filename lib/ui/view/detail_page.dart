import 'dart:async';

import 'package:deperm_bilgi_sistemi/core/constants/string_functions.dart';
import 'package:deperm_bilgi_sistemi/core/models/earthquake_model.dart';
import 'package:deperm_bilgi_sistemi/ui/viewModels/saved_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailPage extends StatefulWidget {
  final Earthquake_model earthquake_model;

  const DetailPage({Key key, this.earthquake_model}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final savedListController = Get.find<SavedListController>();
  double enlem = 0, boylam = 0;
  Earthquake_model myModel;
  CameraPosition _kLake;

  @override
  Widget build(BuildContext context) {
    enlem = double.parse(StringFunctions()
        .descripionToCoordinat(widget.earthquake_model.description)['x']);
    boylam = double.parse(StringFunctions()
        .descripionToCoordinat(widget.earthquake_model.description)['y']);
    Completer<GoogleMapController> _controller = Completer();
    Marker marker = Marker(
        markerId: MarkerId("marker1"),
        draggable: false,
        position: LatLng(enlem, boylam));
    _kLake = CameraPosition(
        bearing: 0, target: LatLng(enlem, boylam), tilt: 0, zoom: 6);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBoddy(marker, _controller),
    );
  }

  Widget _buildBoddy(
      Marker marker, Completer<GoogleMapController> _controller) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: _buildProgresBar(),
          ),
          Expanded(
            flex: 40,
            child: _buildMaps(marker, _controller),
          ),
          Expanded(
            flex: 60,
            child: _buildDetailList(),
          ),
        ],
      ),
    );
  }

  LinearPercentIndicator _buildProgresBar() {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.8,
      lineHeight: 12.0,
      leading: Text(
        StringFunctions()
                .titleSpiltting(widget.earthquake_model.title)['buyukluk'] +
            "     ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      percent: (double.parse(StringFunctions()
              .titleSpiltting(widget.earthquake_model.title)['buyukluk'])) /
          8,
      backgroundColor: Colors.black12,
      progressColor: Color(0xffFFD64D),
    );
  }

  Widget _buildDetailList() {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: ListTile(
              leading: Icon(
                Icons.design_services_sharp,
                color: Color(0xffFFD64D),
              ),
              title: Text("Büyüklük : "),
              subtitle: Text(StringFunctions()
                  .titleSpiltting(widget.earthquake_model.title)['buyukluk']),
            ),
          ),
          Expanded(
            child: ListTile(
              leading: Icon(
                Icons.design_services_sharp,
                color: Color(0xffFFD64D),
              ),
              title: Text(widget.earthquake_model.title),
            ),
          ),
          Expanded(
            child: ListTile(
              leading: Icon(
                Icons.design_services_sharp,
                color: Color(0xffFFD64D),
              ),
              title: Text("Date : "),
              subtitle: Text(widget.earthquake_model.pubDate),
            ),
          ),
          Expanded(
              child: InkWell(
            onTap: _saveModel,
            child: ListTile(
              leading: Icon(
                Icons.save,
                color: Color(0xffFFD64D),
              ),
              title: Text(
                "Veritabanına Kayıt Et",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _saveModel() async {
    //   await SQliteService().insertItem(widget.earthquake_model);
    savedListController.addDeprem(widget.earthquake_model);
    var snackBar = SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text(
          "Veritaba kayıt işlemi başarılıl",
          style: TextStyle(color: Colors.black),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _buildMaps(Marker marker, Completer<GoogleMapController> _controller) {
    return Container(
      margin: EdgeInsets.all(12),
      child: GoogleMap(
        markers: Set.from([marker]),
        mapType: MapType.normal,
        initialCameraPosition: _kLake,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffFFD64D),
      title: Text(
        "Detaylar...",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
