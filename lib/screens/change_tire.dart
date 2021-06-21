import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loco_low_co/configurations/services_list.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dart_airtable/dart_airtable.dart';

class ChangeTireScreen extends StatelessWidget {
  String id = '3';
  ChangeTireScreen();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<BoxShadow> customShadow = [
      BoxShadow(
        color: Colors.grey[300],
        blurRadius: 30,
        offset: Offset(0, 10),
      ),
    ];
    String basePrice = '';
    String minTime = '';
    String imagePath = '';
    servicesList.forEach((service) {
      if (service['id'] == id) {
        basePrice = service['basePrice'];
        minTime = service['minTime'];
        imagePath = service['imagePath'];
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage(imagePath),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 80),
                                    child: MyCustomForm(),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 42,
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.chevron_left),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.tray_arrow_down,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: Container(
              height: 120,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: customShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change Tire",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.timer,
                            color: Colors.black87,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        minTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        basePrice,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Crea un Widget Form
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  String service;
  String name;
  String phone;
  LocationResult _pickedLocation;
  String timeBooked = DateTime.now().add(const Duration(days: 2)).toString();
  @override
  Widget build(BuildContext context) {
    final projectBase = 'ProjectBase';
    final apiKey = 'Token';
    var airtable = Airtable(apiKey: apiKey, projectBase: projectBase);
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: "Name"),
            onChanged: (value) => {name = value},
            validator: (value) {
              if (value.isEmpty) {
                return 'Please a Name';
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Phone"),
            onChanged: (value) => {phone = value},
            validator: (value) {
              if (value.isEmpty) {
                return 'Please a Phone number';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21.0, bottom: 8.0),
            child: Text(_pickedLocation?.address ?? ''),
          ),
          ElevatedButton(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Pick location "),
                  Icon(Icons.gps_fixed),
                ]),
            onPressed: () {
              pickLocation(context);
            },
          ),
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue:
                DateTime.now().add(const Duration(days: 2)).toString(),
            firstDate: DateTime.now().add(const Duration(days: 2)),
            lastDate: DateTime.now().add(const Duration(days: 20)),
            initialTime: TimeOfDay(hour: 10, minute: 0),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            timeLabelText: "Hour",
            onChanged: (val) => timeBooked = val,
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) => timeBooked = val,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // devolverá true si el formulario es válido, o falso si
                // el formulario no es válido.
                if (_formKey.currentState.validate()) {
                  airtable
                      .createRecord(
                    'ChangeTire',
                    AirtableRecord(
                      fields: [
                        AirtableRecordField(
                          fieldName: 'Name',
                          value: name,
                        ),
                        AirtableRecordField(
                          fieldName: 'Phone',
                          value: phone,
                        ),
                        AirtableRecordField(
                          fieldName: 'Direction',
                          value: _pickedLocation.toString() ?? '',
                        ),
                        AirtableRecordField(
                          fieldName: 'Time',
                          value: timeBooked,
                        ),
                      ],
                    ),
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Booked')));
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('Submit')]),
            ),
          ),
        ],
      ),
    );
  }

  pickLocation(BuildContext context) async {
    LocationResult result = await showLocationPicker(
      context,
      "TOKEN",
      initialCenter: LatLng(0, 0),
      automaticallyAnimateToCurrentLocation: true,
//     mapStylePath: 'assets/mapStyle.json',
      myLocationButtonEnabled: true,
      requiredGPS: true,
      layersButtonEnabled: true,
      // countries: ['AE', 'NG']
      resultCardAlignment: Alignment.bottomCenter,
      desiredAccuracy: LocationAccuracy.best,
      buttonMargin: EdgeInsets.only(top: 120, right: 8),
    );
    print("result = $result");
    setState(() => _pickedLocation = result);
  }
}
