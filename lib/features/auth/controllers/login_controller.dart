
class LoginController {
  bool isValidInput({
    required String identifier,
    required String password,
  }) {
    return identifier.trim().isNotEmpty &&
        password.isNotEmpty;
  }
}
