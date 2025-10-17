// ignore_for_file: avoid_print

import 'package:designcter/services/calculator/calculator.dart';

void main () {

  // Spine Calculator
  String spineRes1 = SpineCalculator.spineHeightLoss(
          normalCm: [4.5, 4.6, 4.4],
          collapsedCM: [3.0, 3.1, 2.9],
  );

  print(spineRes1);

  // Mean Calculator
  double? meanRes1 = MeanCalculator.calculate([1.0, 2.0, 3.0]);

  print(meanRes1);

  // Volume Calculator
  String prostateVol1 = VolumeCalculator.prostate([1.0, 2.0, 3.0]);
  print(prostateVol1);
}