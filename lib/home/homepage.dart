import 'package:dashboard_1/home/helper/flask.dart';
import 'package:dashboard_1/notification/notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import './helper/top.dart';
import 'package:flutter/material.dart';

import 'helper/circular.dart';
import 'helper/linear.dart';
import 'helper/phind.dart';
import 'widget/card1.dart';
import 'widget/card2.dart';

class home extends StatelessWidget {
  home({super.key});

  Query dbRef = FirebaseDatabase.instance.ref().child('quality');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              top: width * 0.05, left: width * 0.08, right: width * 0.08),
          child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref("quality/2-push").onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.beat(
                    color: Colors.white,
                    size: 200,
                  ),
                );
              }
              if (snapshot.hasData) {
                final found = snapshot.data!.snapshot.children.toList();

                Map data = found.last.value as Map;
                if (data['pH'] == null ||
                    data['TDS'] == null ||
                    data['Oxygen level'] == null ||
                    data['Temperature'] == null) {
                  return Container();
                }
                double tempP = data['Temperature'] / 50.0;
                double ph = data['pH'].toDouble();
                double temp = data['Temperature'].toDouble();
                double oxy = data['Oxygen level'].toDouble();
                var tds = data['TDS'];
                String phI, tempI, oxyI;
                if (ph > 6.5 && ph <= 7.5) {
                  phI = "Neutral";
                } else if (ph > 7.5 && ph <= 8.5) {
                  phI = "Optimum";
                } else if (ph > 5.5 && ph < 6.5) {
                  phI = "Slightly acidic";
                } else if (ph <= 5.5) {
                  phI = "Acidic";
                } else if (ph > 8.5) {
                  phI = "Basic";
                } else {
                  phI = "Error";
                }

                if (temp >= 25 && temp <= 35) {
                  tempI = "Optimum";
                } else if (temp > 35) {
                  tempI = "High";
                } else if (temp < 25) {
                  tempI = "Low";
                } else {
                  tempI = "Error";
                }

                if (oxy >= 5 && oxy <= 11) {
                  oxyI = "Optimum";
                } else if (oxy > 11) {
                  oxyI = "High";
                } else if (oxy < 5) {
                  oxyI = "Low";
                } else {
                  oxyI = "";
                }
                // notification.showNotifier(id: 0, body: "hello", title: "New");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    top(),
                    card1(
                      header: "Oxygen level",
                      displayVal: oxy,
                      sideText: "ppm",
                      footer: oxyI,
                      sidewidget: flask(value: oxy),
                    ),
                    card1(
                      header: "ph level",
                      displayVal: ph,
                      sideText: "",
                      footer: phI,
                      sidewidget: phind(
                        value: data['pH'].toDouble(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        card2(
                            header: 'Temperature',
                            sider: '°C',
                            val: temp,
                            centerWidget: linearIndicator(temp: tempP),
                            footer: tempI),
                        card2(
                            header: 'TDS',
                            val: tds,
                            sider: 'ppt',
                            centerWidget: circularIndicator(tds: tds),
                            footer: tempI),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.001,
                    )
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
