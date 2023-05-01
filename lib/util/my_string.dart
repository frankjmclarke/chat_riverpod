class MyString {
  static String limitString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      int firstHalf = (maxLength - 3) ~/ 2;
      int secondHalf = firstHalf + (maxLength - 3) % 2;
      return "${input.substring(0, firstHalf)}...${input.substring(input.length - secondHalf)}";
    }
  }
}
