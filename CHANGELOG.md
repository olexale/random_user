# Changelog

## 1.0.0

* **Breaking:** migrate to null safety; requires Dart 3.4 or later.
* **Breaking:** model constructors now take `required` named parameters.
* **Breaking:** `Id.value` is now `String?`, since the service returns `null` for some nationalities.
* **Breaking:** switch to randomuser.me API v1.4. `Location.street` is now a `Street` object with `number` and `name`.
* Add `Location.country`.
* Upgrade `http` to 1.x.
* `RandomUser` accepts an optional `http.Client`, e.g. for mocking in tests.
* `RandomUserException` exposes `statusCode` and handles non-JSON error responses.
* Replace Travis CI with GitHub Actions.

## 0.3.0

* Reformat code

## 0.2.0

* Change Dart requitement to >= 2.1.0
* Remove unneded dependency

## 0.1.0

* Version bump to not to scary Pub users
* Add example
* Code formatting

## 0.0.1

Initial Version of the library.
