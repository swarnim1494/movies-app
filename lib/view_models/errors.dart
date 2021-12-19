class UserFriendlyException implements Exception{
  String message;
  UserFriendlyException({required this.message});
}