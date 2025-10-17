/// Calculator module for DesignCTER radiology calculations
/// 
/// This module provides calculation utilities for radiology reporting,
/// including mean calculations, spine height loss analysis, and volume
/// calculations for prostate measurements.
/// 
/// Example usage:
/// ```dart
/// import 'package:designcter/calculator/calculator.dart';
/// 
/// // Mean calculation
/// final mean = MeanCalculator.calculate([1.1, 1.2, 1.3]);
/// 
/// // Spine height loss calculation
/// final spineResult = SpineCalculator.calculateHeightLoss(4.5, 3.0);
/// print(spineResult.formattedResult); // "Moderate compression fracture (33% height loss)."
/// 
/// // Prostate volume calculation
/// final volumeResult = VolumeCalculator.calculateProstateVolume([4.4, 4.5, 4.6]);
/// print(volumeResult.formattedResult); // "Volume: 47.1 ml (Enlarged)"
/// ```
library;

// Export all public calculators
export 'mean_calculator.dart';
export 'spine_calculator.dart';
export 'volume_calculator.dart';
export 'adrenal_washout_calculator.dart';