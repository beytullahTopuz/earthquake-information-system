class StringFunctions {
  Map<String, String> titleSpiltting(String data) {
    String buyukluk = '';
    String isim = '';
    List<String> dizi = data.split(" ");
    buyukluk = dizi[0];
    dizi.removeAt(0);
    dizi.removeAt(0);
    dizi.removeLast();
    dizi.removeLast();
    dizi.forEach((item) {
      isim = isim + item + ' ';
    });

    return {'isim': isim, 'buyukluk': buyukluk};
  }

  Map<String, String> descripionToCoordinat(String data) {
    String x = '';
    String y = '';
    // double enlem, boylam;
    List<String> dizi = data.split(" ");
    x = dizi.elementAt(4);
    y = dizi.elementAt(5);
    x = deltetPlus(x);
    y = deltetPlus(y);

    return {'x': x, 'y': y};
  }

  Map<String, String> pubDate(String data) {
    List<String> dizi = data.split(" ");
    dizi.removeLast;
    dizi.removeLast;

    return {
      'gun': dizi.first,
      'tarih': dizi[1] + ' ' + dizi[2] + ' ' + dizi[3]
    };
  }

  String deltetPlus(String data) {
    return data.replaceAll(r'+', '');
  }
}
