class ValidateID {
  bool rsaIDNumberValid(String idNumber) {
    return validateSouthAfricanId(idNumber);
  }

  bool validateSouthAfricanId(String idNumber) {
    // Check if the ID number has the correct length
    if (idNumber.length != 13) {
      return false;
    }

    // Extract components from the ID number
    int year = int.parse(idNumber.substring(0, 2));
    int month = int.parse(idNumber.substring(2, 4));
    int day = int.parse(idNumber.substring(4, 6));

    // Check the validity of the date of birth
    if (!isValidDate(year, month, day)) {
      return false;
    }

    // Perform Luhn algorithm check for the check digit
    int checkDigit = int.parse(idNumber.substring(12));
    if (!isValidLuhnCheck(idNumber.substring(0, 12), checkDigit)) {
      return false;
    }

    // If all checks pass, the ID number is valid
    return true;
  }

  bool isValidDate(int year, int month, int day) {
    // Basic checks for valid date components
    if (year < 0 || month < 1 || month > 12 || day < 1 || day > 31) {
      return false;
    }

    // Check for valid month-day combinations
    if ((month == 4 || month == 6 || month == 9 || month == 11) && day > 30) {
      return false;
    } else if (month == 2) {
      // Check for February and leap years
      if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return day <= 29;
      } else {
        return day <= 28;
      }
    }

    return true;
  }

  bool isValidLuhnCheck(String idPrefix, int checkDigit) {
    // Convert the ID prefix to a list of integers
    List<int> digits = idPrefix.split('').map((e) => int.parse(e)).toList();

    // Perform Luhn algorithm check
    int sum = 0;
    for (int i = 0; i < digits.length; i++) {
      int digit = digits[digits.length - 1 - i];
      if (i % 2 == 0) {
        digit *= 2;
        digit = digit > 9 ? digit - 9 : digit;
      }
      sum += digit;
    }

    return (sum + checkDigit) % 10 == 0;
  }
}
