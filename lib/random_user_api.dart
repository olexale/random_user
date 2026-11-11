import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_user/models.dart';

/// Client for the randomuser.me service, a free and easy to use service to
/// generate random user data for application testing.
///
/// Use [getUser] for a randomly generated user.
/// You may call [getUsers] to get a list of random users, or
/// [getUsersWithInfo] to have additional [Info] structure with the response.
///
/// ```dart
/// final api = RandomUser();
/// final user = await api.getUser();
/// final users = await api.getUsers(results: 10);
/// ```
///
/// Parameters shared by all methods:
/// - `seed` allows you to always generate the same set of users.
/// - `gender` might be `male` or `female`; any other value makes the service
///   return both.
/// - `password` sets password generation rules, e.g.
///   `upper,lower,number,8`. See https://randomuser.me/documentation.
///   By default, passwords are chosen from a list of ~10k top used passwords.
/// - `nationalities` is a comma-separated list of nationality codes, e.g.
///   `NO` or `US,GB`. See https://randomuser.me/documentation.
class RandomUser {
  /// Creates a client.
  ///
  /// Pass a custom [client] to reuse connections, add middleware, or mock the
  /// service in tests. The caller is responsible for closing it.
  RandomUser({http.Client? client}) : _client = client;

  final http.Client? _client;

  /// Returns a randomly generated user.
  Future<User> getUser({
    String? seed,
    String? gender,
    String? password,
    String? nationalities,
  }) async {
    final users = await getUsers(
      seed: seed,
      gender: gender,
      password: password,
      nationalities: nationalities,
    );
    return users.first;
  }

  /// Returns a list of randomly generated users.
  ///
  /// [results] is the number of users per request (up to 5,000).
  /// [page] is a 1-based page number. Use it with the same `seed` to get back
  /// the same results.
  Future<List<User>> getUsers({
    int? results,
    int? page,
    String? seed,
    String? gender,
    String? password,
    String? nationalities,
  }) async {
    final response = await getUsersWithInfo(
      results: results,
      page: page,
      seed: seed,
      gender: gender,
      password: password,
      nationalities: nationalities,
    );
    return response.results;
  }

  /// Returns a list of randomly generated users with additional [Info].
  ///
  /// See [getUsers] for [results] and [page].
  ///
  /// Throws [RandomUserException] if the service returns an error.
  Future<RandomUserResponse> getUsersWithInfo({
    int? results,
    int? page,
    String? seed,
    String? gender,
    String? password,
    String? nationalities,
  }) async {
    final uri = Uri.https('randomuser.me', '/api/1.4/', {
      if (results != null) 'results': '$results',
      if (password != null) 'password': password,
      if (seed != null) 'seed': seed,
      if (nationalities != null) 'nat': nationalities,
      if (page != null) 'page': '$page',
      if (gender != null) 'gender': gender,
    });

    final client = _client;
    final response = await (client == null ? http.get(uri) : client.get(uri));

    if (response.statusCode == 200) {
      return RandomUserResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    }

    throw _parseError(response);
  }

  RandomUserException _parseError(http.Response response) {
    try {
      final body = json.decode(response.body);
      if (body is Map<String, dynamic>) {
        return RandomUserException.fromJson(
          body,
          statusCode: response.statusCode,
        );
      }
    } on FormatException {
      // Not JSON, e.g. an HTML error page from a proxy.
    }
    return RandomUserException(
      error: response.reasonPhrase ?? 'HTTP ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }
}
