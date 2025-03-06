class ApiErrorModel {
  final bool? success;
  final int? statusCode;
  final String message;

  const ApiErrorModel({
    this.success,
    this.statusCode,
    this.message = 'Oops! Something went wrong',
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic>? json) {
    return ApiErrorModel(
      success: json?['success'],
      statusCode: json?['status'],
      message: json?['message'],
    );
  }
}

