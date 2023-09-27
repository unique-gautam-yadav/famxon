// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppResponse {
  final bool hasError;
  final String message;
  final Object? data;
  
  const AppResponse({
    required this.hasError,
    required this.message,
    this.data,
  });
}
