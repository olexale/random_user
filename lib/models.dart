/// Contains a list of users from randomuser.me service.
///
/// [results] is a list of users.
/// [info] has additional info, which might be useful for pagination.
class RandomUserResponse {
  /// Creates a response.
  const RandomUserResponse({required this.results, required this.info});

  /// Parses a response from the randomuser.me JSON payload.
  RandomUserResponse.fromJson(Map<String, dynamic> json)
      : info = Info.fromJson(json['info'] as Map<String, dynamic>),
        results = (json['results'] as List<dynamic>)
            .map((r) => User.fromJson(r as Map<String, dynamic>))
            .toList();

  /// A list of randomly generated users.
  final List<User> results;

  /// Additional info, which might be useful for pagination.
  final Info info;
}

/// Randomly generated user from randomuser.me service.
class User {
  /// Creates a user.
  const User({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  /// Parses a user from JSON.
  User.fromJson(Map<String, dynamic> json)
      : gender = json['gender'] as String,
        name = Name.fromJson(json['name'] as Map<String, dynamic>),
        location = Location.fromJson(json['location'] as Map<String, dynamic>),
        email = json['email'] as String,
        login = Login.fromJson(json['login'] as Map<String, dynamic>),
        dob = Dob.fromJson(json['dob'] as Map<String, dynamic>),
        registered =
            Registered.fromJson(json['registered'] as Map<String, dynamic>),
        phone = json['phone'] as String,
        cell = json['cell'] as String,
        id = Id.fromJson(json['id'] as Map<String, dynamic>),
        picture = Picture.fromJson(json['picture'] as Map<String, dynamic>),
        nat = json['nat'] as String;

  /// `male` or `female`.
  final String gender;

  /// User's name.
  final Name name;

  /// User's address, coordinates and timezone.
  final Location location;

  /// User's email.
  final String email;

  /// User's login credentials.
  final Login login;

  /// User's date of birth.
  final Dob dob;

  /// User's registration date.
  final Registered registered;

  /// User's phone number.
  final String phone;

  /// User's cell phone number.
  final String cell;

  /// User's national identifier.
  final Id id;

  /// Links to user's portraits.
  final Picture picture;

  /// User's nationality code, e.g. `US`.
  final String nat;
}

/// User's name.
class Name {
  /// Creates a name.
  const Name({required this.title, required this.first, required this.last});

  /// Parses a name from JSON.
  Name.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        first = json['first'] as String,
        last = json['last'] as String;

  /// Title, e.g. `mr`, `ms`.
  final String title;

  /// First name.
  final String first;

  /// Last name.
  final String last;
}

/// User's location.
class Location {
  /// Creates a location.
  const Location({
    required this.street,
    required this.city,
    required this.state,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  /// Parses a location from JSON.
  Location.fromJson(Map<String, dynamic> json)
      : street = json['street'] as String,
        city = json['city'] as String,
        state = json['state'] as String,
        postcode = json['postcode'].toString(),
        coordinates =
            Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
        timezone = Timezone.fromJson(json['timezone'] as Map<String, dynamic>);

  /// Street address.
  final String street;

  /// City.
  final String city;

  /// State.
  final String state;

  /// Postcode. The service returns either a number or a string, so it is
  /// always converted to a string.
  final String postcode;

  /// Geographic coordinates.
  final Coordinates coordinates;

  /// Timezone.
  final Timezone timezone;
}

/// Geographic coordinates.
class Coordinates {
  /// Creates coordinates.
  const Coordinates({required this.latitude, required this.longitude});

  /// Parses coordinates from JSON.
  Coordinates.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'] as String,
        longitude = json['longitude'] as String;

  /// Latitude.
  final String latitude;

  /// Longitude.
  final String longitude;
}

/// Timezone.
class Timezone {
  /// Creates a timezone.
  const Timezone({required this.offset, required this.description});

  /// Parses a timezone from JSON.
  Timezone.fromJson(Map<String, dynamic> json)
      : offset = json['offset'] as String,
        description = json['description'] as String;

  /// UTC offset, e.g. `+4:00`.
  final String offset;

  /// Human-readable description.
  final String description;
}

/// User's login credentials.
class Login {
  /// Creates login credentials.
  const Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  /// Parses login credentials from JSON.
  Login.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String,
        username = json['username'] as String,
        password = json['password'] as String,
        salt = json['salt'] as String,
        md5 = json['md5'] as String,
        sha1 = json['sha1'] as String,
        sha256 = json['sha256'] as String;

  /// Unique identifier.
  final String uuid;

  /// Username.
  final String username;

  /// Password.
  final String password;

  /// Password salt.
  final String salt;

  /// MD5 hash of the salted password.
  final String md5;

  /// SHA-1 hash of the salted password.
  final String sha1;

  /// SHA-256 hash of the salted password.
  final String sha256;
}

/// Date of birth.
class Dob {
  /// Creates a date of birth.
  const Dob({required this.date, required this.age});

  /// Parses a date of birth from JSON.
  Dob.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String,
        age = json['age'] as int;

  /// ISO 8601 date, e.g. `1946-03-17T16:18:45Z`.
  final String date;

  /// Age in years.
  final int age;
}

/// Registration date.
class Registered {
  /// Creates a registration date.
  const Registered({required this.date, required this.age});

  /// Parses a registration date from JSON.
  Registered.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String,
        age = json['age'] as int;

  /// ISO 8601 date, e.g. `2017-12-09T12:27:02Z`.
  final String date;

  /// Years since registration.
  final int age;
}

/// National identifier.
class Id {
  /// Creates an identifier.
  const Id({required this.name, this.value});

  /// Parses an identifier from JSON.
  Id.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        value = json['value'] as String?;

  /// Identifier type, e.g. `SSN`. May be empty.
  final String name;

  /// Identifier value. `null` for nationalities without one.
  final String? value;
}

/// Links to user's portraits.
class Picture {
  /// Creates a picture.
  const Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  /// Parses a picture from JSON.
  Picture.fromJson(Map<String, dynamic> json)
      : large = json['large'] as String,
        medium = json['medium'] as String,
        thumbnail = json['thumbnail'] as String;

  /// Large portrait URL.
  final String large;

  /// Medium portrait URL.
  final String medium;

  /// Thumbnail URL.
  final String thumbnail;
}

/// Additional request info, useful for pagination.
class Info {
  /// Creates info.
  const Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  /// Parses info from JSON.
  Info.fromJson(Map<String, dynamic> json)
      : seed = json['seed'] as String,
        results = json['results'] as int,
        page = json['page'] as int,
        version = json['version'] as String;

  /// Seed used to generate the users.
  final String seed;

  /// Number of users in the response.
  final int results;

  /// Page number (1-based).
  final int page;

  /// API version.
  final String version;
}

/// Thrown when the randomuser.me service is offline or experiencing issues.
class RandomUserException implements Exception {
  /// Creates an exception.
  const RandomUserException({required this.error, this.statusCode});

  /// Parses an exception from the service's error JSON.
  RandomUserException.fromJson(Map<String, dynamic> json, {this.statusCode})
      : error = json['error'] as String? ?? 'Unknown error';

  /// Error message.
  final String error;

  /// HTTP status code of the failed response, if known.
  final int? statusCode;

  @override
  String toString() => statusCode == null
      ? 'RandomUserException: $error'
      : 'RandomUserException($statusCode): $error';
}
