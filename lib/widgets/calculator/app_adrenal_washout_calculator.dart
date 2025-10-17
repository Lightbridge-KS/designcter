import 'package:flutter/material.dart';
import '../../services/calculator/adrenal_washout_calculator.dart';
import '../components/buttons.dart';

class AppAdrenalWashoutCalculator extends StatefulWidget {
  const AppAdrenalWashoutCalculator({super.key});

  @override
  State<AppAdrenalWashoutCalculator> createState() => _AppAdrenalWashoutCalculatorState();
}

class _AppAdrenalWashoutCalculatorState extends State<AppAdrenalWashoutCalculator> {
  final TextEditingController _preContrastController = TextEditingController();
  final TextEditingController _enhancedController = TextEditingController();
  final TextEditingController _delayedController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  @override
  void dispose() {
    _preContrastController.dispose();
    _enhancedController.dispose();
    _delayedController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _calculate() {
    // Parse enhanced and delayed (required fields)
    final double? enhanced = double.tryParse(_enhancedController.text);
    final double? delayed = double.tryParse(_delayedController.text);

    // Return empty if required fields are invalid
    if (enhanced == null || delayed == null) {
      setState(() {
        _outputController.text = '';
      });
      return;
    }

    // Parse pre-contrast (optional field)
    final double? preContrast = _preContrastController.text.trim().isEmpty
        ? null
        : double.tryParse(_preContrastController.text);

    // Calculate result
    try {
      final result = AdrenalWashoutCalculator.calculate(
        nc: preContrast,
        enh: enhanced,
        delayed: delayed,
      );
      setState(() {
        _outputController.text = result;
      });
    } catch (e) {
      setState(() {
        _outputController.text = 'Error: ${e.toString()}';
      });
    }
  }

  void _resetInputs() {
    setState(() {
      _preContrastController.clear();
      _enhancedController.clear();
      _delayedController.clear();
      _outputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adrenal CT Washout Calculator',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _preContrastController,
                    decoration: const InputDecoration(
                      labelText: 'Pre-contrast (HU) (Optional)',
                      hintText: 'Pre-contrast (HU)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _calculate(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _enhancedController,
                    decoration: const InputDecoration(
                      labelText: 'Enhanced (HU)',
                      hintText: 'e.g. 100',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _calculate(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _delayedController,
                    decoration: const InputDecoration(
                      labelText: '15 Minute Delayed (HU)',
                      hintText: 'e.g. 60',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _calculate(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pre-contrast is optional. If provided, both APW and RPW will be calculated.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'APW >60% or RPW >40% suggests adenoma over malignancy',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _outputController,
                    decoration: const InputDecoration(
                      labelText: 'Washout Result',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: false,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GenerateButton(onPressed: _calculate),
                          const SizedBox(width: 8),
                          CopyButton(controller: _outputController),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: _resetInputs,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}