extension FirebaseConverts on String {
  String encodeEmail() {
    return replaceAll(".", ",");
  }
}