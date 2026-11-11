// Printing is the point of this example.
// ignore_for_file: avoid_print

import 'package:random_user/random_user.dart';

Future<void> main() async {
  final api = RandomUser();

  final randomUser = await api.getUser();
  print("Just a random user's email:");
  print(randomUser.email);

  final randomList = await api.getUsers(results: 3);
  print('Three random users:');
  for (final u in randomList) {
    print('${u.name.first} ${u.name.last}');
  }

  final knownUser = await api.getUsersWithInfo(seed: 'flutter');
  print('Always the same user:');
  print(knownUser.results.first.login.username);
}
