import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:random_user/random_user.dart';
import 'package:test/test.dart';

void main() {
  final fixture = File('test/fixtures/users.json').readAsStringSync();

  group('offline', () {
    late List<Uri> requests;

    RandomUser apiReturning(String body, [int status = 200]) {
      requests = [];
      return RandomUser(
        client: MockClient((request) async {
          requests.add(request.url);
          return http.Response(
            body,
            status,
            headers: {
              'content-type': 'application/json; charset=utf-8',
            },
          );
        }),
      );
    }

    test('builds query from parameters', () async {
      final api = apiReturning(fixture);
      await api.getUsersWithInfo(
        results: 2,
        page: 3,
        seed: 'flutter',
        gender: 'female',
        password: 'upper,8',
        nationalities: 'US,GB',
      );
      final uri = requests.single;
      expect(uri.host, 'randomuser.me');
      expect(uri.path, '/api/1.4/');
      expect(uri.queryParameters, {
        'results': '2',
        'page': '3',
        'seed': 'flutter',
        'gender': 'female',
        'password': 'upper,8',
        'nat': 'US,GB',
      });
    });

    test('omits unset parameters', () async {
      final api = apiReturning(fixture);
      await api.getUser();
      expect(requests.single.queryParameters, isEmpty);
    });

    test('parses users and info', () async {
      final api = apiReturning(fixture);
      final response = await api.getUsersWithInfo();
      expect(response.info.seed, 'flutter');
      expect(response.info.results, 2);
      expect(response.info.page, 1);
      expect(response.info.version, '1.4');

      expect(response.results, hasLength(2));
      final user = response.results.first;
      expect(user.login.username, 'crazygorilla429');
      expect(user.name.first, 'Eleanor');
      expect(user.location.postcode, '88521');
      expect(user.location.street.number, 2851);
      expect(user.location.street.name, 'Cherry St');
      expect(user.location.country, 'United States');
      expect(user.location.coordinates.latitude, 27.2875);
      expect(user.location.coordinates.longitude, 45.1138);
      expect(user.dob.date, DateTime.utc(1946, 4, 29, 7, 2, 4, 12));
      expect(user.dob.date.isUtc, isTrue);
      expect(user.dob.age, 80);
      expect(user.registered.date, DateTime.utc(2021, 9, 29, 18, 21, 58, 721));
      expect(user.id.value, '802-78-7239');
      expect(user.nat, 'US');
    });

    test('handles null id value and string postcode', () async {
      final body = jsonDecode(fixture) as Map<String, dynamic>;
      final user =
          (body['results'] as List<dynamic>).first as Map<String, dynamic>;
      user['id'] = {'name': '', 'value': null};
      (user['location'] as Map<String, dynamic>)['postcode'] = 'K1A 0B1';

      final api = apiReturning(jsonEncode(body));
      final parsed = await api.getUser();
      expect(parsed.id.name, '');
      expect(parsed.id.value, isNull);
      expect(parsed.location.postcode, 'K1A 0B1');
    });

    test('accepts numeric coordinates', () async {
      final body = jsonDecode(fixture) as Map<String, dynamic>;
      final user =
          (body['results'] as List<dynamic>).first as Map<String, dynamic>;
      (user['location'] as Map<String, dynamic>)['coordinates'] = {
        'latitude': -33.5,
        'longitude': 151,
      };

      final api = apiReturning(jsonEncode(body));
      final coordinates = (await api.getUser()).location.coordinates;
      expect(coordinates.latitude, -33.5);
      expect(coordinates.longitude, 151.0);
    });

    test('throws RandomUserException with service error', () async {
      final api =
          apiReturning('{"error": "Uh oh, something bad happened"}', 500);
      await expectLater(
        api.getUser(),
        throwsA(
          isA<RandomUserException>()
              .having((e) => e.error, 'error', 'Uh oh, something bad happened')
              .having((e) => e.statusCode, 'statusCode', 500),
        ),
      );
    });

    test('throws RandomUserException on non-JSON error page', () async {
      final api = apiReturning('<html>Bad Gateway</html>', 502);
      await expectLater(
        api.getUser(),
        throwsA(
          isA<RandomUserException>()
              .having((e) => e.statusCode, 'statusCode', 502),
        ),
      );
    });
  });

  group('live', tags: 'live', () {
    final api = RandomUser();

    test('gender affects gender', () async {
      final user = await api.getUser(gender: 'female');
      expect(user.gender, 'female');
    });

    test('password affects password', () async {
      final user = await api.getUser(password: 'upper,lower,number,8');
      expect(user.login.password, matches(RegExp(r'^[a-zA-Z0-9]{8}$')));
    });

    test('nationalities affects nationality', () async {
      final user = await api.getUser(nationalities: 'NO');
      expect(user.nat, 'NO');
    });

    test('seed returns the same user', () async {
      final user = await api.getUser(seed: 'flutter');
      expect(user.login.username, 'crazygorilla429');
    });

    test('results affects results count', () async {
      final users = await api.getUsers(results: 3);
      expect(users, hasLength(3));
    });

    test('info reflects input query', () async {
      final response = await api.getUsersWithInfo(results: 2, page: 3);
      expect(response.results, hasLength(2));
      expect(response.info.results, 2);
      expect(response.info.page, 3);
      expect(response.info.version, '1.4');
    });
  });
}
