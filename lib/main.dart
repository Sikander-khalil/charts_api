import 'dart:convert';

import 'package:charts_api/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'bar_model.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Charts',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<MyModel> genders = [];

  bool loading = true;

  NetworkHelper _networkHelper = NetworkHelper();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var response = await _networkHelper.get("https://api.genderize.io/?name[]=%20balram&name[]=deepa&name[]=sikander&name[]=ali");

    if (response.statusCode == 200) {
      // Parse the JSON array into a List<MyModel>
      List<dynamic> responseBody = json.decode(response.body);
      List<MyModel> tempdata = responseBody.map((data) => MyModel.fromJson(data)).toList();

      setState(() {
        genders = tempdata;
        loading = false;
      });
    } else {
      // Handle the error here, e.g., show an error message.
      // You can also log the error or take other appropriate actions.
      print("Error: ${response.statusCode}");
      loading = false;
    }
  }


  List<charts.Series<MyModel, String>> _createSampleData() {
    return [
      charts.Series<MyModel, String>(
        data: genders,
        id: "Sales",
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (MyModel mymodel, _) => mymodel.name ?? "Unknown", // Use "Unknown" as the default value if mymodel.name is null
        measureFn: (MyModel mymodel, _) => mymodel.count,

      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Bar Charts"),
      ),
      body: Center(
        child: loading ? CircularProgressIndicator() : Container(
          height: 300,
          child: charts.BarChart(

            _createSampleData(),
            animate: false,

          ),
        ),
      )
    );
  }
}


