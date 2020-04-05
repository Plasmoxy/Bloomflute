const FHOST = 'https://pmxyshopapp.firebaseio.com';
const FAPIKEY = 'AIzaSyAufen1NIz_XjqnP70huBvuE1lTRVnjwHk';

class ApiError implements Exception {
  final String message;
  ApiError(this.message);
  @override
  String toString() => message;
}
