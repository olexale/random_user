# random_user

[![CI](https://github.com/olexale/random_user/actions/workflows/ci.yml/badge.svg)](https://github.com/olexale/random_user/actions/workflows/ci.yml) [![pub package](https://img.shields.io/pub/v/random_user.svg)](https://pub.dev/packages/random_user)

Framework to generate random users. An unofficial Dart/Flutter SDK for https://randomuser.me.

`random_user` is an easy to use Dart package that generates random users and their data for your Dart or Flutter applications. It uses the randomuser.me API.

## Usage

Import the package:

```dart
import 'package:random_user/random_user.dart';
```

Create an instance of `RandomUser` and use `getUser`, `getUsers` or `getUsersWithInfo`:

- `getUser` returns a single random user.
- `getUsers` returns a list of random users.
- `getUsersWithInfo` returns the list together with an `Info` object that helps with pagination.

To get a random user:

```dart
final api = RandomUser();
final user = await api.getUser();
```

A more complex example:

```dart
final api = RandomUser();
final users = await api.getUsers(
  gender: 'female',
  password: 'upper,lower,number,8',
  nationalities: 'NO',
  results: 10,
);
```

This returns 10 female users from Norway with 8-character alphanumeric passwords.

Pass `seed` to always get the same users back.

### Custom HTTP client

You can pass your own `http.Client`, for example to reuse connections or to mock the service in tests:

```dart
final client = http.Client();
final api = RandomUser(client: client);
// ...
client.close();
```

If the service fails, the methods throw a `RandomUserException`.

## License

`random_user` is released under the [MIT License](https://opensource.org/licenses/MIT). See `LICENSE` for details.
