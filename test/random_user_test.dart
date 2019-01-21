import 'package:random_user/random_user.dart';
import "package:test/test.dart";

void main() {
  group("getUser", () {
    test('gender affects gender', () async {
      const expectedGender = 'female';
      final api = RandomUser();
      final user = await api.getUser(gender: expectedGender);
      expect(user.gender, expectedGender);
    });

    test('password affects password', () async {
      final matchingRegExp = RegExp("^[a-zA-Z0-9]{8}\$");
      final api = RandomUser();
      final user = await api.getUser(password: 'upper,lower,number,8');
      expect(matchingRegExp.firstMatch(user.login.password) != null, true);
    });

    test('nationalities affects nationality', () async {
      const expectedNationality = 'NO';
      final api = RandomUser();
      final user = await api.getUser(nationalities: expectedNationality);
      expect(user.nat, expectedNationality);
    });

    test('with seed returns the same user', () async {
      const expectedUsername = 'crazygorilla429';
      final api = RandomUser();
      final user = await api.getUser(seed: 'flutter');
      expect(user.login.username, expectedUsername);
    });
  });

  group("getUsers", () {
    test('getUsers: no params returns one random user', () async {
      final api = RandomUser();
      final response = await api.getUsers();
      expect(response.length, 1);
    });

    test('getUsers: result affects results count', () async {
      const expectedCount = 3;
      final api = RandomUser();
      final response = await api.getUsers(results: expectedCount);
      expect(response.length, expectedCount);
    });
  });

  group("getUsersWithInfo", () {
    test('getUsersWithInfo: info reflects input query', () async {
      const expectedCount = 2;
      const expectedPage = 3;

      final api = RandomUser();
      final response = await api.getUsersWithInfo(
          results: expectedCount, page: expectedPage);
      expect(response.results.length, expectedCount);
      expect(response.info.results, expectedCount);
      expect(response.info.page, expectedPage);
    });
  });
}
