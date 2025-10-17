import 'dart:math' as math;
import '_parser.dart';

class VolumeCalculator {

  /// Calculate prostate volume and provide diagnosis from string input
  /// 
  /// Parameters:
  /// - `input`: String representation of 3 perpendicular diameters (comma/space separated)
  /// 
  /// Returns:
  /// - Formatted diagnosis string with volume and size assessment
  /// - Empty string if input cannot be parsed or doesn't contain exactly 3 dimensions
  static String prostateFromString(String input) {
    dynamic parsed = parseStrToNumOrList(input);
    
    // Handle empty string return from parser
    if (parsed == "") {
      return "";
    }
    
    try {
      // Convert single value to list for consistency
      List<double> dimensions = parsed is double ? [parsed] : parsed;
      
      // Validate exactly 3 dimensions
      if (dimensions.length != 3) {
        return "";
      }
      
      return prostate(dimensions);
    } catch (e) {
      return "";
    }
  }

  /// Calculate prostate volume and provide diagnosis
  /// 
  /// Parameters:
  /// - `dimensions`: List of 3 perpendicular diameters
  /// 
  /// Returns:
  /// - Formatted diagnosis string with volume and size assessment
  static String prostate(List<double> dimensions) {
    if (dimensions.length != 3) {
      throw ArgumentError('Prostate calculation requires exactly 3 dimensions');
    }
    
    double volume = _ellipsoid(dimensions[0], dimensions[1], dimensions[2]);
    String diagnosis;
    
    if (volume < 25) {
      diagnosis = "Normal";
    } else if (volume == 25) {
      diagnosis = "Normal or Prominent";
    } else if (volume < 40) {
      diagnosis = "Prominent";
    } else if (volume == 40) {
      diagnosis = "Prominent or Enlarged";
    } else {
      diagnosis = "Enlarged";
    }
    
    return "$diagnosis size of prostate gland, measuring ${volume.round()} ml in volume.";
  }

  /// Calculate ellipsoid volume from 3 perpendicular diameters
  /// 
  /// Parameters:
  /// - `d1`: First diameter
  /// - `d2`: Second diameter  
  /// - `d3`: Third diameter
  /// 
  /// Returns:
  /// - Volume in cubic units
  static double _ellipsoid(double d1, double d2, double d3) {
    return (4 / 3) * math.pi * (d1 / 2) * (d2 / 2) * (d3 / 2);
  }
}