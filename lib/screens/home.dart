import 'package:flutter/material.dart';
import 'package:loco_low_co/widgets/service_card.dart';
import 'package:loco_low_co/configurations/services_list.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: servicesList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ServiceCard(
                serviceId: servicesList[index]['id'],
                petName: servicesList[index]['name'],
                basePrice: servicesList[index]['basePrice'],
                minTime: servicesList[index]['minTime'],
                imagePath: servicesList[index]['imagePath'],
              ),
            );
          },
        ),
      ),
    );
  }
}
