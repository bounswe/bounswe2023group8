class CustomException implements Exception {
  final String message;
  final String errors;

  CustomException(this.message, this.errors);

  factory CustomException.fromJson(Map<String, dynamic> json) {
    if (json['errors'] is String) {
      return CustomException(
        json['message'],
        json['errors'],
      );
    } else {
      return CustomException(
        'Error',
        json['message'],
      );
    }
  }
}
