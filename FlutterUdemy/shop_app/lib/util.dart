const FHOST = 'https://pmxyshopapp.firebaseio.com';

class ApiError implements Exception {
  final String message;
  ApiError(this.message);
  @override
  String toString() => message;
}
