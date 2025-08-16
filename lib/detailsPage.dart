import 'package:bmicalculator/resultScreen.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String heightUnit = 'cm';
  String weightUnit = 'kg';
  String gender = 'Male';

  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_active, color: Colors.white),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Gender images instead of "Details Page" text
                SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gender = 'Male';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: gender == 'Male'
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/images/female.png', // your male image
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gender = 'Female';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: gender == 'Female'
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/images/male.png', // your female image
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Age
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration("Age"),
                ),
                const SizedBox(height: 20),

                // Height
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Height"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: heightUnit,
                      items: ['cm', 'm', 'ft']
                          .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          heightUnit = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Weight
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Weight"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: weightUnit,
                      items: ['kg', 'lbs']
                          .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          weightUnit = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Old ChoiceChip kept as backup (optional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text("Male"),
                      selected: gender == 'Male',
                      onSelected: (selected) {
                        setState(() {
                          gender = 'Male';
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text("Female"),
                      selected: gender == 'Female',
                      onSelected: (selected) {
                        setState(() {
                          gender = 'Female';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 100),


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    if (heightController.text.isNotEmpty &&
                        weightController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            age: int.tryParse(ageController.text) ?? 0,
                            height:
                            double.tryParse(heightController.text) ?? 0,
                            heightUnit: heightUnit,
                            weight:
                            double.tryParse(weightController.text) ?? 0,
                            weightUnit: weightUnit,
                            gender: gender,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Calculate BMI",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
