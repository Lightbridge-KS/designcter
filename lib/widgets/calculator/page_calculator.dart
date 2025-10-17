import 'package:designcter/widgets/calculator/app_adrenal_washout_calculator.dart';
import 'package:flutter/material.dart';
import '../components/appbarbundle.dart';
import 'app_mean.dart';
import 'app_prostate_volume.dart';
import 'app_spine.dart';

class CalculatorPage extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onThemeToggle;
  
  const CalculatorPage({
    super.key,
    required this.themeMode,
    required this.onThemeToggle,
  });

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBundle(
        title: const Text('Radiology Calculator', style: TextStyle(fontWeight: FontWeight.bold)),
        iconDark: Icons.dark_mode_outlined,
        iconLight: Icons.brightness_5,
        themeMode: widget.themeMode,
        onThemeToggle: widget.onThemeToggle,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppMeanCalculator(),
            SizedBox(height: 32),
            AppProstateVolumeCalculator(),
            SizedBox(height: 32),
            AppSpineCalculator(),
            SizedBox(height: 32),
            AppAdrenalWashoutCalculator(),
          ],
        ),
      ),
    );
  }
}