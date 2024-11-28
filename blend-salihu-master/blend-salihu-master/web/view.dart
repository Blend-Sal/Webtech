import 'dart:html';
import 'model/user.dart';
import 'model/player.dart';
import 'dart:async';

class BridgeBuilderView {
  late Player player;
  bool isAccountFormVisible = false;
  final createAccountButton = querySelector('#create-account');
  final accountForm = querySelector('#account-form');
  final menu = querySelector('#menu');
  final usernameInput = querySelector('#create-username') as InputElement?;
  final passwordInput = querySelector('#create-password') as InputElement?;
  final submitAccountButton = querySelector('#submit-account');
  final playButton = querySelector('#play');
  final myAcountButton = querySelector('#my-account-button');
  final myAccountContainer = querySelector('#my-account-container');
  final cancelAccount = querySelector('#cancel-button');
  final loginButton = querySelector('#login-button');
  final logoMover = querySelector('#logo');
  final returnToButtonLevel = querySelector('#return-to-menu-button');
  final deleteMyAccount = querySelector('#delete-account');
  final deleteAccount = querySelector('#delete-account-form');
  final deleteUsernameInput = querySelector('#delete-username') as InputElement;
  final deletePasswordInput = querySelector('#delete-password') as InputElement;
  final updatePasswordForm = querySelector('#update-account-form-password');
  final updateUsernameForm = querySelector('#update-account-form-username');
  final updateUsernameButton = querySelector('#update-username-button');
  final updatePasswordButton = querySelector('#update-password-button');
  final level1 = querySelector('#level1');
  final updatecurrentUsername =
      querySelector('#update-current-username') as InputElement?;
  final updatenewusername =
      querySelector('#update-new-username') as InputElement?;
  final updatepasswordusername =
      querySelector('#update-password-username') as InputElement?;

  final updatenormalUsername =
      querySelector('#update-username-password') as InputElement;
  final updateCurrentPassword =
      querySelector('#update-current-password') as InputElement;
  final updateNewPassword =
      querySelector('#update-new-password') as InputElement;

  BridgeBuilderView() {
    player = Player();

    updatePasswordButton?.onClick.listen((event) async {
      final currentPassword = updateCurrentPassword.value;
      final newpassword = updateNewPassword.value;
      final username = updatenormalUsername.value;

      if (currentPassword!.isNotEmpty &&
          newpassword!.isNotEmpty &&
          username!.isNotEmpty) {
        try {
          await User.updatePassword(currentPassword, newpassword, username);
          showNotification('Password Successfully updated', isError: false);
        } catch (e) {
          showNotification('Failed to update Password', isError: true);
        }
      } else {
        showNotification('Usernames and password are required', isError: true);
      }
    });

    updateUsernameButton?.onClick.listen((event) async {
      final currentUsername = updatecurrentUsername?.value;
      final newusername = updatenewusername?.value;
      final password = updatepasswordusername?.value;

      if (currentUsername != null &&
          newusername != null &&
          password != null &&
          currentUsername.isNotEmpty &&
          newusername.isNotEmpty &&
          password.isNotEmpty) {
        try {
          await User.updateUsername(currentUsername, newusername, password);
          showNotification('Username Succefully updated', isError: false);
        } catch (e) {
          showNotification('Failed to update Username', isError: true);
        }
      } else {
        showNotification(
          'Usernames and password are required',
          isError: true,
        );
      }
    });

    deleteMyAccount?.onClick.listen((event) async {
      final deleteUsername = deleteUsernameInput.value;
      final deletePassword = deletePasswordInput.value;

      if (deleteUsername != null &&
          deletePassword != null &&
          deleteUsername.isNotEmpty &&
          deletePassword.isNotEmpty) {
        try {
          await User.deleteUser(deleteUsername, deletePassword);
          showNotification('Account deleted successfully', isError: false);
        } catch (e) {
          showNotification('Failed to delete account', isError: true);
        }
      } else {
        showNotification(
          'Username and password are required for account deletion',
          isError: true,
        );
      }
    });

    loginButton?.onClick.listen((event) async {
      event.preventDefault();
      final username = usernameInput?.value;
      final password = passwordInput?.value;

      if (username != null &&
          password != null &&
          username.isNotEmpty &&
          password.isNotEmpty) {
        try {
          await User.loginUser(username, password);
          showNotification('Login successful!', isError: false);
        } catch (e) {
          showNotification('Failed to Login', isError: true);
        }
      } else {
        showNotification('Username and password are required', isError: true);
      }
    });

    submitAccountButton?.onClick.listen((event) async {
      event.preventDefault();

      final username = usernameInput?.value;
      final password = passwordInput?.value;

      if (username != null &&
          password != null &&
          username.isNotEmpty &&
          password.isNotEmpty) {
        try {
          await User.registerUser(username, password, 1);
          showNotification('Registration successful!', isError: false);
        } catch (e) {
          showNotification('Failed to Register User', isError: true);
        }
      } else {
        showNotification('Username and password are required', isError: true);
      }
    });
  }

  void update() {
    final levels = document.querySelectorAll('.level');
    for (var i = 0; i < levels.length; i++) {
      final level = levels[i] as DivElement;
      final nextLevelButton =
          level.querySelector('.next-level-button') as ButtonElement?;

      if (player.bridgeBuilt && player.onPlatform) {
        nextLevelButton?.style.display = 'block';
      } else {
        nextLevelButton?.style.display = 'none';
      }
    }
  }

  void updateUser(String username) {
    final usernameElement = querySelector('#username-display');
    if (usernameElement != null) {
      usernameElement.text = 'Logged in as: $username';
    }
  }

  void showLevel1() {
    level1?.style.display = 'flex';
  }

  void hideleve1() {
    level1?.style.display = 'none';
  }

  void showupdateUsernameForm() {
    updateUsernameForm?.style.display = 'flex';
  }

  void hideupdateUsernameForm() {
    updateUsernameForm?.style.display = 'none';
  }

  void showupdatePasswordForm() {
    updatePasswordForm?.style.display = 'flex';
  }

  void hideupdatePasswordForm() {
    updatePasswordForm?.style.display = 'none';
  }

  void hidedeleteAccountform() {
    deleteAccount?.style.display = 'none';
  }

  void showdeleteAccountform() {
    deleteAccount?.style.display = 'flex';
  }

  void showreturnButtonLevel() {
    returnToButtonLevel?.style.display = 'flex';
  }

  void hidereturnButtonLevel() {
    returnToButtonLevel?.style.display = 'none';
  }

  void showLogo() {
    logoMover?.style.display = 'flex';
  }

  void hideLogo() {
    logoMover?.style.display = 'none';
  }

  void showmyAccountContainer() {
    myAccountContainer?.style.display = 'flex';
  }

  void hidemyAccountContainer() {
    myAccountContainer?.style.display = 'none';
  }

  void showAccountForm() {
    accountForm?.style.display = 'flex';
  }

  void hideAccountForm() {
    accountForm?.style.display = 'none';
  }

  void showMenu() {
    menu?.style.display = 'flex';
  }

  void hideMenu() {
    menu?.style.display = 'none';
  }

  void registrationFailedNotification() {
    showNotification('Registration failed. Username already exists.',
        isError: true);
  }

  void showFieldRequiredNotification() {
    showNotification('Username and password are required.', isError: true);
  }

  void loginErrorNotification() {
    showNotification('Invalid username or password.', isError: true);
  }

  void showLevelCompletionMessage() {
    final levelContainer = querySelector('#level-container');
    levelContainer?.innerHtml = '';
    final completionMessage = DivElement()
      ..text = 'Congratulations! You have completed all levels.';
    levelContainer?.append(completionMessage);
  }

  void showLevels(int levelIndex) {
    final levels = document.querySelectorAll('.level');
    for (var level in levels) {
      level.style.display = 'none';
    }

    final levelId = '#level$levelIndex';
    final levelToShow = querySelector(levelId);
    if (levelToShow != null) {
      levelToShow.style.display = 'block';
    }
  }

  void showAllLevelsCompletedMessage() {
    final levelContainer = querySelector('#menu');
    levelContainer?.innerHtml = '<p>All levels completed! Congratulations!</p>';
  }

  void showNotification(String message, {bool isError = false}) {
    final notification = querySelector('#notification');
    if (notification != null) {
      notification.text = message;
      notification.style.backgroundColor = isError ? 'red' : 'green';
      notification.style.color = 'white';
      notification.classes.add('show');
      Timer(Duration(seconds: 5), () {
        notification.classes.remove('show');
      });
    }
  }
}
