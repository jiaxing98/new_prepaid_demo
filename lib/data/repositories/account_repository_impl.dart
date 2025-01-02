import 'package:new_prepaid_demo/domain/models/profile.dart';
import 'package:new_prepaid_demo/domain/models/reload_history.dart';
import 'package:new_prepaid_demo/domain/repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  @override
  Future<Profile> getProfile() async {
    await Future.delayed(Duration(seconds: 3));
    return _mockProfile;
  }

  @override
  Future<void> changeName(String name) async {
    await Future.delayed(Duration(seconds: 1));
    _mockProfile = Profile(
      name: name,
      email: _mockProfile.email,
      plan: _mockProfile.plan,
      accountNumber: _mockProfile.accountNumber,
    );
  }

  @override
  Future<void> changeEmail(String currentEmail, String newEmail) async {
    await Future.delayed(Duration(seconds: 1));
    _mockProfile = Profile(
      name: _mockProfile.name,
      email: newEmail,
      plan: _mockProfile.plan,
      accountNumber: _mockProfile.accountNumber,
    );
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await Future.delayed(Duration(seconds: 1));
    _mockProfile = Profile(
      name: _mockProfile.name,
      email: _mockProfile.email,
      plan: _mockProfile.plan,
      accountNumber: _mockProfile.accountNumber,
    );
  }

  @override
  Future<List<ReloadHistory>> getReloadHistories() async {
    await Future.delayed(Duration(seconds: 1));

    return List.generate(
      5,
      (index) => ReloadHistory(
        amount: 10.0 * index,
        dateTime: DateTime.now().subtract(Duration(days: 100 - index)),
      ),
    )
      ..addAll(
        List.generate(
          5,
          (index) => ReloadHistory(
            amount: 10.0 * index,
            dateTime: DateTime.now().subtract(Duration(days: 30 - index)),
          ),
        ),
      )
      ..addAll(
        List.generate(
          5,
          (index) => ReloadHistory(
            amount: 10.0 * index,
            dateTime: DateTime.now().subtract(Duration(days: 60 - index)),
          ),
        ),
      );
  }

  Profile _mockProfile = Profile(
    name: "folieadeux",
    email: "folieadeux@redone.com.my",
    plan: "Pak Ultra",
    accountNumber: "39587325",
  );

  Profile get mockProfile => _mockProfile;

  List<ReloadHistory> _mockHistory = List.generate(
    5,
    (index) => ReloadHistory(
      amount: 10.0 * index,
      dateTime: DateTime.now().subtract(Duration(days: 100 - index)),
    ),
  )
    ..addAll(
      List.generate(
        5,
        (index) => ReloadHistory(
          amount: 10.0 * index,
          dateTime: DateTime.now().subtract(Duration(days: 30 - index)),
        ),
      ),
    )
    ..addAll(
      List.generate(
        5,
        (index) => ReloadHistory(
          amount: 10.0 * index,
          dateTime: DateTime.now().subtract(Duration(days: 60 - index)),
        ),
      ),
    );

  List<ReloadHistory> get mockHistory => _mockHistory;
}
