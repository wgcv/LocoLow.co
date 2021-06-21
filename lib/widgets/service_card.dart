import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loco_low_co/screens/car_wash.dart';
import 'package:loco_low_co/screens/change_oil.dart';
import 'package:loco_low_co/screens/change_tire.dart';

class ServiceCard extends StatelessWidget {
  String serviceId;
  String petName = '';
  String minTime = '';
  String basePrice = '';
  String imagePath = '';
  List<BoxShadow> customShadow = [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 30,
      offset: Offset(0, 10),
    ),
  ];
  ServiceCard({
    this.serviceId,
    this.petName,
    this.minTime,
    this.basePrice,
    this.imagePath,
  });

  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              if (serviceId == "1") {
                return CarWashScreen();
              } else if (serviceId == "2") {
                return ChangeOilScreen();
              } else if (serviceId == "3") {
                return ChangeTireScreen();
              }
              return CarWashScreen();
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 240,
        child: Stack(
          children: [
            Container(
              // height: 200,
              margin: EdgeInsets.only(
                top: 50,
                bottom: 50,
              ),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.48,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                petName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                minTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: fadedBlack,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            basePrice,
                            style: TextStyle(
                              fontSize: 12,
                              // color: fadedBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: customShadow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              width: size.width * 0.42,
              child: Stack(
                children: [
                  Align(
                    child: Hero(
                      tag: serviceId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          imagePath,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
