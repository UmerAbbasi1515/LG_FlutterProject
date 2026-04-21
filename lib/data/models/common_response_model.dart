// class ApiResponse<T> {
//   final int? statusCode;
//   final String? message;
//   final T? data;

//   ApiResponse({
//      this.statusCode,
//      this.message,
//      this.data,
//   });

//   factory ApiResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(dynamic json) fromJsonT,
//   ) {
//     return ApiResponse<T>(
//       statusCode: json['statusCode'] ?? 0,
//       message: json['message'] ?? '',
//       data: fromJsonT(json['data']),
//     );
//   }
// }

class ApiResponse<T> {
  final int? statusCode;
  final String? message;
  final String? messageUr;
  final T? data;

  ApiResponse({
    this.statusCode,
    this.message,
    this.messageUr,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    final rawData = json['data'];

    return ApiResponse<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      messageUr: json['messageUr'],
      data: rawData == null ? null : fromJsonT(rawData),
    );
  }
}
