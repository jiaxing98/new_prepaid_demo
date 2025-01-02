import 'package:new_prepaid_demo/domain/models/profile.dart';
import 'package:new_prepaid_demo/domain/models/reload_history.dart';

abstract class AccountRepository {
  Future<Profile> getProfile();

  Future<void> changeName(String name);

  Future<void> changeEmail(String currentEmail, String newEmail);

  Future<void> changePassword(String currentPassword, String newPassword);

  Future<List<ReloadHistory>> getReloadHistories();
}
