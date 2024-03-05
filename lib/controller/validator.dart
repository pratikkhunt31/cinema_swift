import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validator {
  static bool validateField(String title, String value) {
    if (value.trim().isNotEmpty) {
      return true;
    }
    Get.snackbar(
      "Error",
      "$title is Empty",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
    return false;
  }

  static bool validatePass(String v1, String v2) {
    if (v1.trim() == v2.trim()) {
      return true;
    }
    Get.snackbar(
      "Error",
      "Confirm Password is not match",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
    return false;
  }
}
