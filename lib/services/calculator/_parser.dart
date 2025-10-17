dynamic parseStrToNumOrList(String x) {

  try {
    // Split the string into parts based on comma or one or more spaces
    List<String> parts = x.trim().split(RegExp(r'[,\s]+'));
    
    // Filter out empty strings and convert to double
    List<double> res = parts
        .where((part) => part.isNotEmpty)
        .map((part) => double.parse(part))
        .toList();
    
    if (res.length == 1) {
      // Ex: [1.1] will convert to 1.1
      return res[0];
    }
    if (res.length > 1) {
      // Ex: [1.1, 1.2, 1.3, 1.45]
      return res;
    }
  } on FormatException {
    // Return empty string for any string that is not compatible (including empty strings)
    return "";
  }


  return "";
}
