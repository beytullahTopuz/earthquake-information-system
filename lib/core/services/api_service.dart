import 'dart:convert';

import 'package:deperm_bilgi_sistemi/core/models/earthquake_model.dart';
import 'package:xml2json/xml2json.dart';
import 'package:xml_parser/xml_parser.dart';

class APIservice {
  Future<List<Earthquake_model>> getAPI() async {
    XmlDocument xmlDocument =
        await XmlDocument.fromUri('http://koeri.boun.edu.tr/rss/');
    var xml = xmlDocument.children[2];

    var xmlstr = xml.toString();
    final Xml2Json xml2Json = Xml2Json();
    xml2Json.parse(xmlstr);
    var jsonString = xml2Json.toParker();
    var data = jsonDecode(jsonString);
    var itemList = data['rss']['channel']['item'];
    List<Earthquake_model> depremList = [];

    var item = itemList[0];
    print(item);
    Earthquake_model tempModel;
    for (var item in itemList) {
      tempModel = Earthquake_model.fromJson(item);
      depremList.add(tempModel);
    }

    return depremList;
  }
}
