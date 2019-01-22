library random_user;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_user/models.dart';

/// Client for the randomuser.me service - a free and easy to use service to generate random user data for application testing.
///
/// Use [getUser] for a randomly generated user.
/// You may call [getUsers] to get a list of random users, or [getUsersWithInfo] to have additional [Info] structure with the response.
///
/// Code sample:
/// ```dart
/// final api = RandomUser();
/// final user = api.getUser();
/// final users = api.getUsers();
/// ```
class RandomUser {
  /// Returns a randomly generated user.
  ///
  /// Parameters:
  /// [seed] allow you to always generate the same set of users.
  /// [gender] specifies whether you would like to have males or females only. Might be "male" or "female", any other value will cause the service to return both male and female users.
  /// [password] sets password generation rules. Refer to [documentation](https://randomuser.me/documentation) for details. By default, passwords are chosen randomly from a list of ~10k top used passwords.
  /// [nationalities] request a different nationality of a random user. Supported values "AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NO, NL, NZ, TR, US". Refer to [documentation](https://randomuser.me/documentation) for details.
  Future<User> getUser(
      {String seed,
      String gender,
      String password,
      String nationalities}) async {
    final users = await getUsers(
        seed: seed,
        gender: gender,
        password: password,
        nationalities: nationalities);
    return users.first;
  }

  /// Returns a list of randomly generated users.
  ///
  /// Parameters:
  /// [results] is a number of generates users in one request (up to 5,000)
  /// [page] You can request multiple pages of a seed with the page parameter. Make sure that you use the same seed and page number (1 based index) in order to get back the same results.
  /// [seed] allow you to always generate the same set of users.
  /// [gender] specifies whether you would like to have males or females only. Might be "male" or "female", any other value will cause the service to return both male and female users.
  /// [password] sets password generation rules. Refer to [documentation](https://randomuser.me/documentation) for details. By default, passwords are chosen randomly from a list of ~10k top used passwords.
  /// [nationalities] request a different nationality of a random user. Supported values "AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NO, NL, NZ, TR, US". Refer to [documentation](https://randomuser.me/documentation) for details.
  Future<List<User>> getUsers(
      {int results,
      int page,
      String seed,
      String gender,
      String password,
      String nationalities}) async {
    final info = await getUsersWithInfo(
        results: results,
        page: page,
        seed: seed,
        gender: gender,
        nationalities: nationalities,
        password: password);
    return info.results;
  }

  /// Returns a list of randomly generated users with additional [Info] structure.
  ///
  /// Parameters:
  /// [results] is a number of generates users in one request (up to 5,000)
  /// [page] You can request multiple pages of a seed with the page parameter. Make sure that you use the same seed and page number (1 based index) in order to get back the same results.
  /// [seed] allow you to always generate the same set of users.
  /// [gender] specifies whether you would like to have males or females only. Might be "male" or "female", any other value will cause the service to return both male and female users.
  /// [password] sets password generation rules. Refer to [documentation](https://randomuser.me/documentation) for details. By default, passwords are chosen randomly from a list of ~10k top used passwords.
  /// [nationalities] request a different nationality of a random user. Supported values "AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NO, NL, NZ, TR, US". Refer to [documentation](https://randomuser.me/documentation) for details.
  Future<RandomUserResponse> getUsersWithInfo(
      {int results,
      int page,
      String seed,
      String gender,
      String password,
      String nationalities}) async {
    final queryParameters = Map.fromEntries(_buildQueryParams(
        results: results,
        password: password,
        page: page,
        seed: seed,
        gender: gender,
        nationalities: nationalities));
    final uri = Uri.https('randomuser.me', '/api/1.2/', queryParameters);

    final response = await http.get(uri);
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200)
      return RandomUserResponse.fromJson(responseJson);

    throw RandomUserException.fromJson(responseJson);
  }

  Iterable<MapEntry<String, String>> _buildQueryParams(
      {int results,
      int page,
      String seed,
      String gender,
      String password,
      String nationalities}) sync* {
    if (results != null) yield MapEntry('results', results.toString());
    if (password != null) yield MapEntry('password', password);
    if (seed != null) yield MapEntry('seed', seed);
    if (nationalities != null) yield MapEntry('nat', nationalities);
    if (page != null) yield MapEntry('page', page.toString());
    if (gender != null) yield MapEntry('gender', gender.toString());
  }
}
