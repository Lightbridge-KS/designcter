import 'package:flutter_test/flutter_test.dart';
import 'package:designcter/services/designcter/designer.dart';
import 'dart:developer' as developer;

void main() {
  // Set up a basic Flutter app context for testing
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Designer Tests', () {
    testWidgets('Test 1: Basic CT protocol (ct_whole_abd_routine)', (WidgetTester tester) async {
      developer.log('=== DesignCTER Quick Test ===\n', name: 'DesignerTest');
      developer.log('Test 1: Basic CT protocol (ct_whole_abd_routine)', name: 'DesignerTest');
      developer.log('-' * 50, name: 'DesignerTest');
      
      try {
        final designer1 = Designer(protocolId: 'ct_whole_abd_routine');
        final result1 = await designer1.generate();
        developer.log('Generated CT Protocol:', name: 'DesignerTest');
        developer.log(result1, name: 'DesignerTest');
        developer.log('\n${'=' * 50}', name: 'DesignerTest');
        
        // Basic assertions
        expect(result1, isNotEmpty);
        expect(result1, contains('-')); // Should contain template content
      } catch (e) {
        developer.log('Error: $e', name: 'DesignerTest', level: 1000);
        fail('Designer failed to generate CT protocol: $e');
      }
    });

    testWidgets('Test 3: MRI protocol (mri_screening_whole_spine)', (WidgetTester tester) async {
      developer.log('Test 3: MRI protocol (mri_screening_whole_spine)', name: 'DesignerTest');
      developer.log('-' * 50, name: 'DesignerTest');
      
      try {
        final designer3 = Designer(
          protocolId: 'mri_screening_whole_spine',
          hasETT: false,
          hasC1: true,
          hasPrecaution: 'Claustrophobic - may need sedation',
          refPhysicianName: 'Dr. Johnson',
        );
        final result3 = await designer3.generate();
        developer.log('Generated MRI Protocol:', name: 'DesignerTest');
        developer.log(result3, name: 'DesignerTest');
        developer.log('\n${'=' * 50}', name: 'DesignerTest');
        
        // MRI-specific assertions
        expect(result3, isNotEmpty);
        expect(result3, contains('MRI')); // Should contain MRI content
        expect(result3, contains('Dr. Johnson')); // Physician name
        expect(result3, contains('Yes')); // C1 status
        expect(result3, contains('Claustrophobic')); // Precaution
        
      } catch (e) {
        developer.log('Error: $e', name: 'DesignerTest', level: 1000);
        fail('Designer failed to generate MRI protocol: $e');
      }
    });

    testWidgets('Test 4: CTA protocol (cta_pe_no_dvt)', (WidgetTester tester) async {
      developer.log('Test 4: CTA protocol (cta_pe_no_dvt)', name: 'DesignerTest');
      developer.log('-' * 50, name: 'DesignerTest');
      
      try {
        final designer4 = Designer(
          protocolId: 'cta_pe_no_dvt',
          npoTime: '4 hours',
          egfrValue: '95',
          pregnancy: false,
          refPhysicianName: 'Dr. Wilson',
        );
        final result4 = await designer4.generate();
        developer.log('Generated CTA Protocol:', name: 'DesignerTest');
        developer.log(result4, name: 'DesignerTest');
        developer.log('\n${'=' * 50}', name: 'DesignerTest');
        
        // CTA-specific assertions
        expect(result4, isNotEmpty);
        expect(result4, contains('4 hours')); // NPO time
        expect(result4, contains('95')); // eGFR value
        expect(result4, contains('Dr. Wilson')); // Physician name
        
      } catch (e) {
        developer.log('Error: $e', name: 'DesignerTest', level: 1000);
        fail('Designer failed to generate CTA protocol: $e');
      }
    });

    test('Test 5: Invalid protocol ID should throw exception', () async {
      developer.log('Test 5: Invalid protocol ID handling', name: 'DesignerTest');
      developer.log('-' * 50, name: 'DesignerTest');
      
      final designer5 = Designer(protocolId: 'invalid_protocol_id');
      
      expect(
        () async => await designer5.generate(),
        throwsException,
      );
      
      developer.log('✓ Exception correctly thrown for invalid protocol ID\n', name: 'DesignerTest');
      developer.log('=' * 50, name: 'DesignerTest');
    });

    test('Test 6: Constructor parameter validation', () {
      developer.log('Test 6: Constructor parameter validation', name: 'DesignerTest');
      developer.log('-' * 50, name: 'DesignerTest');
      
      // Test required parameter
      expect(
        () => Designer(protocolId: 'ct_whole_abd_routine'),
        returnsNormally,
      );
      
      // Test with optional parameters
      expect(
        () => Designer(
          protocolId: 'ct_whole_abd_routine',
          npoTime: '6 hours',
          pregnancy: true,
        ),
        returnsNormally,
      );
      
      developer.log('✓ Constructor parameters validated successfully\n', name: 'DesignerTest');
      developer.log('=' * 50, name: 'DesignerTest');
    });
  });
}