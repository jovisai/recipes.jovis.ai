String slugify(String string) {
  return string.replaceAll(RegExp(r"[^a-zA-Z0-9]+"), "-").toLowerCase();
}

class Constants {
  static String favorites = "Favorites";
  static String hearted = "hearted_channels";
}

class AppDefault {
  static const double xxFontSize = 38;
  static const double xFontSize = xxFontSize / 1.618;
  static const double mmFontSize = xFontSize / 1.618;
  static const List<double> fontSizes = [14, 16, 18];

  static const double sizeDown = 2;
  static const String fontFamily = 'Quicksand';
}

//
//  Status codes
//         * 0: Show only title
//         * 1: Show only title and Summary
//         * 2: Show only title, summary and image
//         * 3: Show only title and image
//         * 4: Show only image
//         * 5: Show only image and summary
class ShowDefinitions {
  static const int onlyTitle = 0;
  static const int onlyTitleAndSummary = 1;
  static const int onlyTitleSummaryAndImage = 2;
  static const int onlyTitleAndImage = 3;
  static const int onlyImage = 4;
  static const int onlyImageAndSummary = 5;
}
