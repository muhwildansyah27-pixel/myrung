class RegisterController {
  bool isValidInput({
    required String nama,
    required String identifier,
    required String password,
    required String konfirmasiPassword,
  }) {
    return nama.trim().isNotEmpty &&
        identifier.trim().isNotEmpty &&
        password.isNotEmpty &&
        konfirmasiPassword.isNotEmpty &&
        password == konfirmasiPassword;
  }
}
