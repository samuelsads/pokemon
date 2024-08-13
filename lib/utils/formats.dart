class Formats {
  String formatId(int id) {
    int minDigits = 2;

    if (id >= 100) {
      minDigits = 4;
    } else if (id >= 10) {
      minDigits = 3;
    }

    return id.toString().padLeft(minDigits, '0');
  }

  String formatText(String stat) {
    List<String> parts = stat.split('-');

    if (parts.length == 1) {
      if (parts[0].length <= 2) {
        return parts[0];
      }
      return stat.substring(0, 3).toUpperCase();
    } else {
      return parts.map((word) => word[0].toUpperCase()).join();
    }
  }
}
