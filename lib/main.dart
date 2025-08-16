import 'package:bmicalculator/detailsPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent, // smoother than shade50
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 130),
              Center(
                child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "BMI ",
                        style: TextStyle(
                          fontSize: 180,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0) ,
                child: Row(children: [
                  Text('Calculator',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.indigo[500],
                    ),
                  ),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(" Welcome to the BMI Calculator, your personal tool for tracking your body mass index and maintaining a healthy lifestyle.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo[500],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 90),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
                  },
                  child: Container(width: double.infinity,
                    height : 60,decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('START',style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),)),),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
