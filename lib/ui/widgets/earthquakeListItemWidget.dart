import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EarthquakeListItem extends StatelessWidget {
  const EarthquakeListItem({
    Key key,
    @required this.context,
    @required this.value,
  }) : super(key: key);

  final BuildContext context;

  final Map<String, String> value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2)),
      margin: EdgeInsets.all(5),
      height: 160,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                value['isim'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      value['buyukluk'],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Icon(Icons.home_repair_service_outlined)
                  ],
                )),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.9,
                  lineHeight: 14.0,
                  percent: (double.parse(value['buyukluk'])) / 9,
                  backgroundColor: Colors.black12,
                  progressColor: Color(0xffFFD64D),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text("Detaylar   "),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
