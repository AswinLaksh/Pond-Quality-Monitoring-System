import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../charts/chart.dart';
import '../../theme/theme.dart';

class card1 extends StatelessWidget {
  const card1(
      {super.key,
      required this.sidewidget,
      required this.header,
      required this.displayVal,
      required this.sideText,
      required this.footer});
  final Widget sidewidget;
  final String header;
  final displayVal;
  final String sideText;
  final String footer;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => chart(
            sider: sideText,
            last: displayVal,
            wanted: header,
          ),
        ),
      ),
      child: Container(
        height: height * 0.175,
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.02,
          top: 6,
          bottom: 6,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: !themeProvider.isDark ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                Text(
                  header.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "SF-Pro",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  displayVal.toString() + " " + sideText,
                  style: const TextStyle(
                    fontFamily: "SF-Pro",
                    fontSize: 37,
                  ),
                ),
                Spacer(),
                Text(
                  footer,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontFamily: "SF-Pro",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
              ],
            ),
            sidewidget
          ],
        ),
      ),
    );
  }
}


