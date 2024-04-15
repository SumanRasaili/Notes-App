class Validators{
    static String? isRequired(String? input) {
    if (input == null || input.isEmpty) {
      return "This is a required field.";
    } else {
      return null;
    }
  }

    static String? dateTime(DateTime? input) {
    if (input == null) {
      return "This is a required field.";
    }
    return null;
  }
}