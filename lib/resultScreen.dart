import 'package:flutter/material.dart';
import 'dart:math';

class ResultPage extends StatelessWidget {
  final int age;
  final double height; // in cm, m, or ft
  final String heightUnit; // 'cm', 'm', 'ft'
  final double weight; // in kg or lbs
  final String weightUnit; // 'kg', 'lbs'
  final String gender;

  const ResultPage({
    super.key,
    required this.age,
    required this.height,
    required this.heightUnit,
    required this.weight,
    required this.weightUnit,
    required this.gender,
  });

  double calculateBMI() {
    // Convert height to meters
    double heightInMeters;
    if (heightUnit.toLowerCase() == 'cm') {
      heightInMeters = height / 100;
    } else if (heightUnit.toLowerCase() == 'm') {
      heightInMeters = height;
    } else if (heightUnit.toLowerCase() == 'ft') {
      heightInMeters = height * 0.3048;
    } else {
      throw Exception("Invalid height unit");
    }

    // Convert weight to kilograms
    double weightInKg;
    if (weightUnit.toLowerCase() == 'lbs') {
      weightInKg = weight * 0.45359237;
    } else if (weightUnit.toLowerCase() == 'kg') {
      weightInKg = weight;
    } else {
      throw Exception("Invalid weight unit");
    }

    if (heightInMeters <= 0) {
      throw Exception("Height must be greater than zero");
    }

    return weightInKg / pow(heightInMeters, 2);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi <= 24.9) return "Normal weight";
    if (bmi <= 29.9) return "Overweight";
    return "Obese";
  }

  Color getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi <= 24.9) return Colors.green;
    if (bmi <= 29.9) return Colors.orange;
    return Colors.red;
  }

  IconData getBMIIcon(double bmi) {
    if (bmi < 18.5) return Icons.trending_down;
    if (bmi <= 24.9) return Icons.check_circle;
    if (bmi <= 29.9) return Icons.warning;
    return Icons.error;
  }

  String getHealthTip(double bmi) {
    if (bmi < 18.5) return "Consider consulting a healthcare professional about healthy weight gain strategies.";
    if (bmi <= 24.9) return "Great job! Maintain your healthy lifestyle with balanced diet and regular exercise.";
    if (bmi <= 29.9) return "Consider incorporating more physical activity and a balanced diet into your routine.";
    return "Consult with a healthcare professional for personalized guidance on achieving a healthy weight.";
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    String category = getBMICategory(bmi);
    Color categoryColor = getBMIColor(bmi);
    IconData categoryIcon = getBMIIcon(bmi);
    String healthTip = getHealthTip(bmi);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF2D3436),
        title: const Text(
          "BMI Results",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Main BMI Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      categoryColor.withOpacity(0.8),
                      categoryColor.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: categoryColor.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Icon(
                        categoryIcon,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Your BMI",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        bmi.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Personal Info Cards
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.cake,
                      title: "Age",
                      value: "$age years",
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildInfoCard(
                      icon: gender.toLowerCase() == 'male' ? Icons.male : Icons.female,
                      title: "Gender",
                      value: gender,
                      color: gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.height,
                      title: "Height",
                      value: "${height.toStringAsFixed(1)} $heightUnit",
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.monitor_weight,
                      title: "Weight",
                      value: "${weight.toStringAsFixed(1)} $weightUnit",
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // BMI Scale
              _buildBMIScale(bmi),

              const SizedBox(height: 30),

              // Health Tip Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Health Tip",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      healthTip,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF636E72),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Calculate Again"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: categoryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF636E72),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF2D3436),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMIScale(double bmi) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "BMI Scale",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 20),
          _buildScaleItem("Underweight", "< 18.5", Colors.blue, bmi < 18.5),
          _buildScaleItem("Normal", "18.5 - 24.9", Colors.green, bmi >= 18.5 && bmi <= 24.9),
          _buildScaleItem("Overweight", "25.0 - 29.9", Colors.orange, bmi >= 25.0 && bmi <= 29.9),
          _buildScaleItem("Obese", "> 30.0", Colors.red, bmi > 30.0),
        ],
      ),
    );
  }

  Widget _buildScaleItem(String category, String range, Color color, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? color : Colors.grey.withOpacity(0.2),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? color : const Color(0xFF2D3436),
              ),
            ),
          ),
          Text(
            range,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? color : const Color(0xFF636E72),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}