import 'dart:async';
import 'dart:ui';

import 'package:deperm_bilgi_sistemi/core/services/api_service.dart';
import 'package:deperm_bilgi_sistemi/ui/view/list_page.dart';
import 'package:deperm_bilgi_sistemi/ui/viewModels/earthquake_controller.dart';
import 'package:deperm_bilgi_sistemi/ui/viewModels/saved_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final EarthquakeController depremController = Get.put(EarthquakeController());
  final SavedListController savedListController =
      Get.put(SavedListController());
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  @override
  void initState() {
    super.initState();
    getEathquake();
    startTimer();
  }

  Timer _timer;
  int _start = 2;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          gotolistPage();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> getEathquake() async {
    var result = await APIservice().getAPI();
    savedListController.getDeprems();
    depremController.addDeprem(result);
  }

  void gotolistPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ListPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFD64D),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 5,
            child: Image.asset("lib/assets/deprem.png"),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Deprem APP",
              style: GoogleFonts.firaCode(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
