import "_statistics.dart"; 
import '_parser.dart';

/// Mean calculator for statistical calculations
/// 
/// Provides functionality to calculate the arithmetic mean of a list of numbers
/// Used primarily for dose calculations in radiology
class MeanCalculator {
  
  /// Calculate the arithmetic mean from string input
  /// 
  /// Parameters:
  /// - `input`: String representation of numbers (single or comma/space separated)
  /// 
  /// Returns:
  /// - Formatted string with the mean value
  /// - Empty string if input cannot be parsed
  static String calculateFromString(String input) {
    dynamic parsed = parseStrToNumOrList(input);
    
    // Handle empty string return from parser
    if (parsed == "") {
      return "";
    }
    
    try {
      double? result = calculate(parsed);
      return result?.toString() ?? "";
    } catch (e) {
      return "";
    }
  }


  /// Calculate the arithmetic mean of a single number or list of numbers
  /// 
  /// Parameters:
  /// - `input`: Either a single double value or a List of double
  /// 
  /// Returns:
  /// - The mean value as a double
  /// - Returns the input value if it's a single number
  /// - Returns null if input is null
  /// 
  /// Throws:
  /// - ArgumentError if the input is an empty list
  static double? calculate(dynamic input) {
    if (input == null) {
      return null;
    }
    
    if (input is double) {
      return input;
    }
    
    if (input is List<double>) {
      if (input.isEmpty) {
        throw ArgumentError('Cannot calculate mean of empty list');
      }
      return Statistics.mean(input);
    }
    
    throw ArgumentError('Input must be either a double or List<double>, got: ${input.runtimeType}');
  }
}
