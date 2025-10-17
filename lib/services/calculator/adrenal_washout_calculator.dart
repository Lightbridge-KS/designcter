/// Adrenal CT Washout Calculator Bussiness Logic
class AdrenalWashoutCalculator {
  static String calculate({
    double? nc,
    required double enh,
    required double delayed,
  }) {
    final String rpwDisp = calcRpw(enh: enh, delayed: delayed).toStringAsFixed(1);

    if (nc != null) {
      final String apwDisp = calcApw(nc: nc, enh: enh, delayed: delayed).toStringAsFixed(1);
      return "APW = $apwDisp%, RPW = $rpwDisp%";
    }

    return "RPW = $rpwDisp%";
  }

  /// Calculates the Absolute Percentage Washout (APW)
  static double calcApw({
    required double nc,
    required double enh,
    required double delayed,
  }) {
    if (enh == nc) {
      throw ArgumentError('Enhanced and non-contrast values cannot be equal');
    }
    final double apw = (enh - delayed) / (enh - nc) * 100;
    return apw;
  }

  /// Calculates the Relative Percentage Washout (RPW)
  static double calcRpw({required double enh, required double delayed}) {
    if (enh == 0) {
      throw ArgumentError('Enhanced value cannot be zero');
    }
    return (enh - delayed) / enh * 100;
  }
}

/// For Testing
// void main() {
//   print(AdrenalWashoutCalculator.calcApw(nc: 10, enh: 100, delayed: 60));
//   print(AdrenalWashoutCalculator.calcRpw(enh: 100, delayed: 60));
//   print(AdrenalWashoutCalculator.calculate(enh: 100, delayed: 60));
//   print(AdrenalWashoutCalculator.calculate(nc: 10, enh: 100, delayed: 60));
// }
