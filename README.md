# random_user

[![CI](https://github.com/olexale/random_user/actions/workflows/ci.yml/badge.svg)](https://github.com/olexale/random_user/actions/workflows/ci.yml) [![pub package](https://img.shields.io/pub/v/random_user.svg)](https://pub.dev/packages/random_user)

An unofficial Dart/Flutter SDK for [randomuser.me](https://randomuser.me), a free service that generates random user data for testing and prototyping. It uses API version 1.4.

## Usage

```dart
import 'package:random_user/random_user.dart';

final api = RandomUser();

// A single random user.
final user = await api.getUser();
print('${user.name.first} ${user.name.last} <${user.email}>');

// 10 female users from Norway with 8-character alphanumeric passwords.
final users = await api.getUsers(
  results: 10,
  gender: 'female',
  nationalities: 'NO',
  password: 'upper,lower,number,8',
);
```

`RandomUser` has three methods:

- `getUser` returns a single `User`.
- `getUsers` returns a `List<User>`.
- `getUsersWithInfo` returns the users together with an `Info` object (seed, page, result count, API version).

All of them accept these parameters:

| Parameter | Description |
|---|---|
| `results` | Number of users, up to 5,000. Not available on `getUser`. |
| `page` | 1-based page number, see [Pagination](#pagination). Not available on `getUser`. |
| `seed` | Any string. The same seed always generates the same users. |
| `gender` | `male` or `female`. Any other value returns both. |
| `nationalities` | Comma-separated codes, e.g. `US` or `GB,IE`. See [Nationalities](#nationalities). |
| `password` | Password rules, e.g. `upper,lower,number,8` or `special,32-64`. See the [randomuser.me documentation](https://randomuser.me/documentation#passwords). |

## What a user contains

| Field | Type | Example |
|---|---|---|
| `gender` | `String` | `female` |
| `name` | `Name` | `.title` `Mrs`, `.first` `Eleanor`, `.last` `Caldwell` |
| `email` | `String` | `eleanor.caldwell@example.com` |
| `phone`, `cell` | `String` | `(935) 522-6351` |
| `location` | `Location` | `.street.number` `2851`, `.street.name` `Cherry St`, `.city`, `.state`, `.country`, `.postcode` |
| `location.coordinates` | `Coordinates` | `.latitude` `27.2875`, `.longitude` `45.1138` (`double`) |
| `location.timezone` | `Timezone` | `.offset` `+4:00`, `.description` |
| `login` | `Login` | `.uuid`, `.username`, `.password`, `.salt`, `.md5`, `.sha1`, `.sha256` |
| `dob`, `registered` | `Dob`, `Registered` | `.date` (UTC `DateTime`), `.age` |
| `id` | `Id` | `.name` `SSN`, `.value` (`String?`, `null` for some nationalities) |
| `picture` | `Picture` | `.large`, `.medium`, `.thumbnail` image URLs |
| `nat` | `String` | `US` |

`postcode` is always a `String`, because some countries use letters in postcodes.

## Pagination

Use the same `seed` with a different `page` to load more users from the same set:

```dart
final first = await api.getUsersWithInfo(seed: 'my-app', results: 20, page: 1);
final second = await api.getUsersWithInfo(seed: 'my-app', results: 20, page: 2);

print(second.info.page); // 2
```

Without a seed, the service picks a random one, and you can read it from `info.seed`.

## Nationalities

`AU`, `BR`, `CA`, `CH`, `DE`, `DK`, `ES`, `FI`, `FR`, `GB`, `IE`, `IN`, `IR`, `MX`, `NL`, `NO`, `NZ`, `RS`, `TR`, `UA`, `US`.

The nationality affects names, addresses, phone numbers and ID formats.

## Error handling

If the service returns an error, the methods throw a `RandomUserException`:

```dart
try {
  final user = await api.getUser();
} on RandomUserException catch (e) {
  print('randomuser.me failed (${e.statusCode}): ${e.error}');
}
```

## Testing

`RandomUser` takes an optional `http.Client`. Pass a `MockClient` from `package:http/testing.dart` to test your code without network access:

```dart
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:random_user/random_user.dart';

final api = RandomUser(
  client: MockClient((request) async {
    return http.Response(cannedJson, 200);
  }),
);
```

Here `cannedJson` is a response body you saved from the service, for example from `https://randomuser.me/api/1.4/?seed=test`.

A custom client is also useful for reusing connections or adding middleware. If you create the client, you close it.

## License

`random_user` is released under the [MIT License](https://opensource.org/licenses/MIT). See `LICENSE` for details.
