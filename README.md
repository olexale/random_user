# random_user  [![Build Status](https://travis-ci.org/olexale/random_user.svg?branch=master)](https://travis-ci.org/olexale/random_user) [![Coverage Status](https://coveralls.io/repos/github/olexale/random_user/badge.svg?branch=master)](https://coveralls.io/github/olexale/random_user?branch=master)

Framework to Generate Random Users - An Unofficial Dart/Flutter SDK for https://randomuser.me

`random_user` is an easy to use Dart framework that provides the ability to generate random users and their accompanying data for your Dart of Flutter applications. It utilizes randomuser.me API to generate the data.

## Usage
Import the framework
```dart
import 'package:random_user/random_user.dart';
```
Create an instance of `RandomUser` class and use the `getUser`, `getUsers` or `getUsersWithInfo` methods.
`getUser` will return a randomly generated user model.
Use `getUsers` to get a list of random users.
Call `getUsersWithInfo` to get not only a list of users, but additional `Info` structure which may help with pagination.

To get just a random user use:
```dart
  final api = RandomUser();
  final user = await api.getUser();
```

More complex sample
```dart
  final api = RandomUser();
  final users = await api.getUsers(gender: 'female', 
                                   password: 'upper,lower,number,8', 
                                   nationalities: 'NO', 
                                   results: 10);
```
Will return 10 females user accounts from Norway with alpha-numberical 8-symbol passwords.

## License
`random_user` is released under an [MIT License](https://opensource.org/licenses/MIT). See `LICENSE` for details.
