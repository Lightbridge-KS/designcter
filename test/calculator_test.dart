import 'package:flutter_test/flutter_test.dart';
import 'package:designcter/services/calculator/calculator.dart';
import 'dart:developer' as developer;

void main() {
  group('Calculator Tests', () {
    group('MeanCalculator', () {
      test('calculate returns correct type (double) for single value', () {
        final result = MeanCalculator.calculate(5.5);

        expect(result, isA<double>());
        developer.log('Single value result: $result', name: 'MeanCalculator');
      });

      test('calculate returns correct type (double) for list of values', () {
        final result = MeanCalculator.calculate([1.1, 1.2, 1.3, 1.4]);

        expect(result, isA<double>());
        developer.log('List values result: $result', name: 'MeanCalculator');
      });

      test('calculate returns correct type (null) for null input', () {
        final result = MeanCalculator.calculate(null);

        expect(result, isNull);
        developer.log('Null input result: $result', name: 'MeanCalculator');
      });

      test('calculate throws ArgumentError for empty list', () {
        expect(
          () => MeanCalculator.calculate(<double>[]),
          throwsA(isA<ArgumentError>()),
        );
        developer.log('Empty list case: correctly throws ArgumentError', name: 'MeanCalculator');
      });

      test('calculate throws ArgumentError for invalid type', () {
        expect(
          () => MeanCalculator.calculate("invalid"),
          throwsA(isA<ArgumentError>()),
        );
        developer.log('Invalid type case: correctly throws ArgumentError', name: 'MeanCalculator');
      });

      test('calculateFromString returns correct type (String) for single value', () {
        final result = MeanCalculator.calculateFromString('5.5');

        expect(result, isA<String>());
        expect(result, equals('5.5'));
        developer.log('Single value from string result: $result', name: 'MeanCalculator');
      });

      test('calculateFromString returns correct type (String) for multiple values', () {
        final result = MeanCalculator.calculateFromString('1.1, 1.2, 1.3, 1.4');

        expect(result, isA<String>());
        expect(result, isNotEmpty);
        developer.log('Multiple values from string result: $result', name: 'MeanCalculator');
      });

      test('calculateFromString returns empty string for invalid input', () {
        final result = MeanCalculator.calculateFromString('invalid');

        expect(result, equals(''));
        developer.log('Invalid string input result: $result', name: 'MeanCalculator');
      });
    });

    group('SpineCalculator', () {
      test('spineHeightLoss returns correct type (String)', () {
        // Test with normal case
        final result = SpineCalculator.spineHeightLoss(
          normalCm: [4.5, 4.6, 4.4],
          collapsedCM: [3.0, 3.1, 2.9],
        );

        expect(result, isA<String>());
        developer.log('Normal case result: $result', name: 'SpineCalculator');
      });

      test('spineHeightLoss handles single values', () {
        final result = SpineCalculator.spineHeightLoss(
          normalCm: [4.5],
          collapsedCM: [3.0],
        );

        expect(result, isA<String>());
        expect(result, contains('compression fracture'));
        expect(result, contains('% height loss'));
        developer.log('Single value result: $result', name: 'SpineCalculator');
      });

      test('spineHeightLoss handles multiple severity levels', () {
        // Test mild compression (< 20%)
        final mildResult = SpineCalculator.spineHeightLoss(
          normalCm: [4.0],
          collapsedCM: [3.3], // ~17.5% loss
        );
        expect(mildResult, contains('Less than mild'));
        developer.log('Mild case: $mildResult', name: 'SpineCalculator');

        // Test moderate compression (25-40%)
        final moderateResult = SpineCalculator.spineHeightLoss(
          normalCm: [4.0],
          collapsedCM: [2.5], // ~37.5% loss
        );
        expect(moderateResult, contains('Moderate'));
        developer.log('Moderate case: $moderateResult', name: 'SpineCalculator');

        // Test severe compression (> 40%)
        final severeResult = SpineCalculator.spineHeightLoss(
          normalCm: [4.0],
          collapsedCM: [2.0], // 50% loss
        );
        expect(severeResult, contains('Severe'));
        developer.log('Severe case: $severeResult', name: 'SpineCalculator');
      });

      test('spineHeightLoss return empty string for negative loss', () {
        final emptyResult = SpineCalculator.spineHeightLoss(
            normalCm: [3.0],
            collapsedCM: [4.0], // Collapsed > normal
        );
        expect(emptyResult, equals("")); 
        developer.log('Negative loss case: return empty string', name: 'SpineCalculator');
      });

      test('spineHeightLoss handles edge case percentages', () {
        // Test exactly 25% loss
        final result25 = SpineCalculator.spineHeightLoss(
          normalCm: [4.0],
          collapsedCM: [3.0], // exactly 25% loss
        );
        expect(result25, contains('Mild to moderate'));
        developer.log('25% loss case: $result25', name: 'SpineCalculator');

        // Test exactly 40% loss
        final result40 = SpineCalculator.spineHeightLoss(
          normalCm: [5.0],
          collapsedCM: [3.0], // exactly 40% loss
        );
        expect(result40, contains('Moderate to severe'));
        developer.log('40% loss case: $result40', name: 'SpineCalculator');
      });

      test('spineHeightLossFromString returns correct type (String)', () {
        final result = SpineCalculator.spineHeightLossFromString(
          normalCm: '4.5, 4.6, 4.4',
          collapsedCM: '3.0, 3.1, 2.9',
        );

        expect(result, isA<String>());
        expect(result, contains('compression fracture'));
        developer.log('From string normal case result: $result', name: 'SpineCalculator');
      });

      test('spineHeightLossFromString handles single values', () {
        final result = SpineCalculator.spineHeightLossFromString(
          normalCm: '4.5',
          collapsedCM: '3.0',
        );

        expect(result, isA<String>());
        expect(result, contains('compression fracture'));
        developer.log('From string single value result: $result', name: 'SpineCalculator');
      });

      test('spineHeightLossFromString returns empty string for invalid input', () {
        final result = SpineCalculator.spineHeightLossFromString(
          normalCm: 'invalid',
          collapsedCM: '3.0',
        );

        expect(result, equals(''));
        developer.log('From string invalid input result: $result', name: 'SpineCalculator');
      });
    });

    group('VolumeCalculator', () {
      test('prostate returns correct type (String)', () {
        final result = VolumeCalculator.prostate([4.4, 4.5, 4.6]);

        expect(result, isA<String>());
        expect(result, contains('prostate gland'));
        expect(result, contains('ml in volume'));
        developer.log('Prostate normal case result: $result', name: 'VolumeCalculator');
      });

      test('prostate handles small volume (Normal)', () {
        final result = VolumeCalculator.prostate([2.0, 2.0, 2.0]);

        expect(result, isA<String>());
        expect(result, contains('Normal'));
        developer.log('Prostate small volume result: $result', name: 'VolumeCalculator');
      });

      test('prostate handles large volume (Enlarged)', () {
        final result = VolumeCalculator.prostate([5.0, 5.0, 5.0]);

        expect(result, isA<String>());
        expect(result, contains('Enlarged'));
        developer.log('Prostate large volume result: $result', name: 'VolumeCalculator');
      });

      test('prostate throws ArgumentError for wrong number of dimensions', () {
        expect(
          () => VolumeCalculator.prostate([4.4, 4.5]),
          throwsA(isA<ArgumentError>()),
        );
        developer.log('Wrong dimensions case: correctly throws ArgumentError', name: 'VolumeCalculator');
      });


      test('prostateFromString handles space-separated values', () {
        final result = VolumeCalculator.prostateFromString('4.4 4.5 4.6');

        expect(result, isA<String>());
        expect(result, contains('prostate gland'));
        developer.log('Prostate from string space-separated result: $result', name: 'VolumeCalculator');
      });

      test('prostateFromString returns empty string for invalid input', () {
        final result = VolumeCalculator.prostateFromString('invalid');

        expect(result, equals(''));
        developer.log('Prostate from string invalid input result: $result', name: 'VolumeCalculator');
      });

      test('prostateFromString returns empty string for wrong number of dimensions', () {
        final result = VolumeCalculator.prostateFromString('4.4, 4.5');

        expect(result, equals(''));
        developer.log('Prostate from string wrong dimensions result: $result', name: 'VolumeCalculator');
      });
    });
  });
}
