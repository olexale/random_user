import 'package:meta/meta.dart';

/// Contains a list of users from randomuser.me service.
///
/// [results] is a list of users
/// [info] has additional info, which might be useful for pagination
@immutable
class RandomUserResponse {
  /// A list of randomly generated users
  final List<User> results;
  // Additional info, which might be useful for pagination
  final Info info;

  RandomUserResponse({this.results, this.info});

  RandomUserResponse.fromJson(Map<String, dynamic> json)
      : info = Info.fromJson(json['info']),
        results =
            json['results'].map((r) => User.fromJson(r)).cast<User>().toList();
}

// Randomly generated user from randomuser.me service
@immutable
class User {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final Login login;
  final Dob dob;
  final Registered registered;
  final String phone;
  final String cell;
  final Id id;
  final Picture picture;
  final String nat;

  User(
      {this.gender,
      this.name,
      this.location,
      this.email,
      this.login,
      this.dob,
      this.registered,
      this.phone,
      this.cell,
      this.id,
      this.picture,
      this.nat});

  User.fromJson(Map<String, dynamic> json)
      : gender = json['gender'],
        name = Name.fromJson(json['name']),
        location = Location.fromJson(json['location']),
        email = json['email'],
        login = Login.fromJson(json['login']),
        dob = Dob.fromJson(json['dob']),
        registered = Registered.fromJson(json['registered']),
        phone = json['phone'],
        cell = json['cell'],
        id = Id.fromJson(json['id']),
        picture = Picture.fromJson(json['picture']),
        nat = json['nat'];
}

@immutable
class Name {
  final String title;
  final String first;
  final String last;

  Name({this.title, this.first, this.last});

  Name.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        first = json['first'],
        last = json['last'];
}

@immutable
class Location {
  final String street;
  final String city;
  final String state;
  final String postcode;
  final Coordinates coordinates;
  final Timezone timezone;

  Location(
      {this.street,
      this.city,
      this.state,
      this.postcode,
      this.coordinates,
      this.timezone});

  Location.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        city = json['city'],
        state = json['state'],
        postcode = json['postcode'].toString(),
        coordinates = Coordinates.fromJson(json['coordinates']),
        timezone = Timezone.fromJson(json['timezone']);
}

@immutable
class Coordinates {
  final String latitude;
  final String longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];
}

@immutable
class Timezone {
  final String offset;
  final String description;

  Timezone({this.offset, this.description});

  Timezone.fromJson(Map<String, dynamic> json)
      : offset = json['offset'],
        description = json['description'];
}

@immutable
class Login {
  final String uuid;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  Login(
      {this.uuid,
      this.username,
      this.password,
      this.salt,
      this.md5,
      this.sha1,
      this.sha256});

  Login.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        username = json['username'],
        password = json['password'],
        salt = json['salt'],
        md5 = json['md5'],
        sha1 = json['sha1'],
        sha256 = json['sha256'];
}

@immutable
class Dob {
  final String date;
  final int age;

  Dob({this.date, this.age});

  Dob.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        age = json['age'];
}

@immutable
class Registered {
  final String date;
  final int age;

  Registered({this.date, this.age});

  Registered.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        age = json['age'];
}

@immutable
class Id {
  final String name;
  final String value;

  Id({this.name, this.value});

  Id.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];
}

@immutable
class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json)
      : large = json['large'],
        medium = json['medium'],
        thumbnail = json['thumbnail'];
}

@immutable
class Info {
  final String seed;
  final int results;
  final int page;
  final String version;

  Info({this.seed, this.results, this.page, this.version});

  Info.fromJson(Map<String, dynamic> json)
      : seed = json['seed'],
        results = json['results'],
        page = json['page'],
        version = json['version'];
}

/// If random user API service is offline or experiencing server issues, you'll get this error.
@immutable
class RandomUserException implements Exception {
  final String error;

  RandomUserException({this.error});

  RandomUserException.fromJson(Map<String, dynamic> json)
      : error = json['error'];
}
