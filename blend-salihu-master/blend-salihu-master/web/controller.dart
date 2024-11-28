import 'dart:async';
import 'dart:html';
import 'view.dart';
import 'model/level.dart';
import 'model/player.dart';
import 'model/user.dart';

class Controller {
  BridgeBuilderView view;
  Level level;
  Player player;
  Level? currentLevel;
  int currentLevelIndex = 0;

  Controller(this.view, this.level, this.player) {
    player = Player();
  }

  void start() {
    final createAccountButton = querySelector('#create-account');
    final playButton = querySelector('#play');
    final returnToMenuButton = querySelector('#return-to-menu');
    final submitButtonAccount = querySelector('#submit-account');
    final usernameInput = querySelector('#create-username') as InputElement?;
    final passwordInput = querySelector('#create-password') as InputElement?;
    final username = usernameInput?.value;
    final password = passwordInput?.value;
    final myAccountButton = querySelector('#my-account-button');
    final loginButton = querySelector('#login-button');
    final cancelAccount = querySelector('#cancel-button');
    final returnToMenuButtonLevel = querySelector('#return-to-menu-button');
    final deleteMyAccount = querySelector('#delete-my-account');
    final returntoMenudeletebutton = querySelector('#return-to-menu-delete');
    final deleteAccountFormButton = querySelector('#delete-account');
    final updateUsernameorig = querySelector('#update-username');
    final updatePasswordorig = querySelector('#update-password');
    final returnToMenuPassword = querySelector('#return-to-menu-password');
    final returnToMenuUsername = querySelector('#return-to-menu-update');
    final updatePasswordButton = querySelector('#update-password-button');
    final updateUsernameButton = querySelector('#update-username-button');
    final deleteUsernameInput =
        querySelector('#delete-username') as InputElement;
    final deletePasswordInput =
        querySelector('#delete-password') as InputElement;

    final updatecurrentPassword =
        querySelector('#update-username-password') as InputElement?;
    final updatenewPassword =
        querySelector('#update-current-password') as InputElement?;
    final updateusernamepassword =
        querySelector('#update-password-username') as InputElement?;

    final updatecurrentUsername =
        querySelector('#update-current-username') as InputElement?;
    final updatenewusername =
        querySelector('#update-new-username') as InputElement?;
    final updatepasswordusername =
        querySelector('#update-password-username') as InputElement?;

    returnToMenuUsername?.onClick.listen((event) {
      view.showMenu();
      view.showLogo();
      view.hideAccountForm();
      view.hideleve1();
      view.hidedeleteAccountform();
      view.hidemyAccountContainer();
      view.hidereturnButtonLevel();
      view.hideupdatePasswordForm();
      view.hideupdateUsernameForm();
    });

    returnToMenuPassword?.onClick.listen((event) {
      view.showMenu();
      view.showLogo();
      view.hideAccountForm();
      view.hideleve1();
      view.hidedeleteAccountform();
      view.hidemyAccountContainer();
      view.hidereturnButtonLevel();
      view.hideupdatePasswordForm();
      view.hideupdateUsernameForm();
    });

    updatePasswordorig?.onClick.listen((event) {
      view.showupdatePasswordForm();
      view.showLogo();
      view.hidedeleteAccountform();
      view.hideleve1();
      view.hideAccountForm();
      view.hidereturnButtonLevel();
      view.hideMenu();
      view.hidemyAccountContainer();
    });

    updateUsernameorig?.onClick.listen((event) {
      view.showupdateUsernameForm();
      view.showLogo();
      view.hidedeleteAccountform();
      view.hideleve1();
      view.hideAccountForm();
      view.hidereturnButtonLevel();
      view.hideMenu();
      view.hidemyAccountContainer();
      view.hideupdatePasswordForm();
    });

    returntoMenudeletebutton?.onClick.listen((event) {
      view.hidedeleteAccountform();
      view.showMenu();
      view.showLogo();
      view.hideAccountForm();
      view.hideleve1();
      view.hidemyAccountContainer();
      view.hidereturnButtonLevel();
    });

    deleteMyAccount?.onClick.listen((event) {
      view.showLogo();
      view.hideAccountForm();
      view.hideleve1();
      view.hidemyAccountContainer();
      view.hidereturnButtonLevel();
      view.showdeleteAccountform();
      view.hideMenu();
    });

    returnToMenuButtonLevel?.onClick.listen((event) {
      view.hidereturnButtonLevel();
      view.showMenu();
      view.hideAccountForm();
      view.hideleve1();
      view.hidemyAccountContainer();
      view.showLogo();
    });

    cancelAccount?.onClick.listen((event) {
      view.hidemyAccountContainer();
      view.showMenu();
      view.hideAccountForm();
      view.hideleve1();
    });

    createAccountButton?.onClick.listen((event) {
      view.hideMenu();
      view.showAccountForm();
      view.hidemyAccountContainer();
      view.hidereturnButtonLevel();
    });

    myAccountButton?.onClick.listen((event) {
      view.hideMenu();
      view.showmyAccountContainer();
      view.hideAccountForm();
      view.hidereturnButtonLevel();
      view.hideleve1();
    });

    returnToMenuButton?.onClick.listen((event) {
      view.showMenu();
      view.hideAccountForm();
      view.hidemyAccountContainer();
      view.hidereturnButtonLevel();
      view.hideleve1();

    });

    playButton?.onClick.listen((event) {
      view.hideMenu();
      view.hideAccountForm();
      view.hidemyAccountContainer();
      view.hideLogo();
      view.showreturnButtonLevel();
      view.showLevel1();

      loginButton?.onClick.listen((event) async {
        final username = usernameInput?.value;
        final password = passwordInput?.value;

        if (username != null &&
            password != null &&
            username.isNotEmpty &&
            password.isNotEmpty) {
          loginUser();
        }
      });

      updateUsernameButton?.onClick.listen((event) {
        final oldusername = updatecurrentUsername?.value;
        final newusername = updatenewusername?.value;
        final password = updatepasswordusername?.value;

        if (oldusername != null &&
            newusername != null &&
            password != null &&
            oldusername.isNotEmpty &&
            newusername.isNotEmpty &&
            password.isNotEmpty) {
          updateUsername();
        }
      });

      deleteAccountFormButton?.onClick.listen((event) async {
        final username = deleteUsernameInput.value;
        final password = deletePasswordInput.value;

        if (username != null &&
            password != null &&
            username.isNotEmpty &&
            password.isNotEmpty) {
          deleteUser();
        }
      });

      updatePasswordButton?.onClick.listen((event) async {
        final username = updateusernamepassword?.value;
        final password = updatecurrentPassword?.value;
        final newPassword = updatenewPassword?.value;

        if (username != null &&
            password != null &&
            newPassword != null &&
            username.isNotEmpty &&
            password.isNotEmpty &&
            newPassword.isNotEmpty) {
          updatePassword();
        }
      });

      final nextLevelButtons = document.querySelectorAll('.next-level-button');
      for (var i = 0; i < nextLevelButtons.length; i++) {
        final nextLevelButton = nextLevelButtons[i] as ButtonElement;
        nextLevelButton.onClick.listen((event) {
          player.destroyBridge();
          currentLevel!.levelCompleted();
        });
      }

      submitButtonAccount?.onClick.listen((event) {
        if (username != null &&
            password != null &&
            username.isNotEmpty &&
            password.isNotEmpty) {
          registerUser();
        }
      });

      Timer(Duration(milliseconds: 100), () {
        currentLevel = Level(player, view);
        currentLevel?.activate();
      });
    });
  }

  void registerUser() {
    final usernameInput = querySelector('#username') as InputElement?;
    final passwordInput = querySelector('#password') as InputElement?;
    if (usernameInput != null && passwordInput != null) {
      String? username = usernameInput.value;
      String? password = passwordInput.value;
      if (username != null && password != null) {
        User.registerUser(username, password, currentLevel?.currentLevel ?? 1);
        view.updateUser(username);
      }
    }
  }

  void deleteUser() {
    final deleteUsernameInput =
        querySelector('#delete-username') as InputElement;
    final deletePasswordInput =
        querySelector('#delete-password') as InputElement;
    String? username = deleteUsernameInput.value;
    String? password = deletePasswordInput.value;
    if (username != null && password != null) {
      User.deleteUser(username, password);
      view.updateUser(username);
    }
  }

  void levelCompleted() {
    currentLevelIndex++;
    if (currentLevelIndex < 3) {
      view.showLevels(currentLevelIndex);
    } else {
      view.showAllLevelsCompletedMessage();
    }
  }

  void loginUser() {
    final usernameInput = querySelector('#my-username') as InputElement?;
    final passwordInput = querySelector('#my-password') as InputElement?;
    if (usernameInput != null && passwordInput != null) {
      String? username = usernameInput.value;
      String? password = passwordInput.value;
      if (username != null && password != null) {
        User.loginUser(username, password);
        view.updateUser(username);
      }
    }
  }

  void deleteUserNotif(String username, String password) {
    User.deleteUser(username, password).then((response) {
      view.showNotification('User deleted successfully', isError: false);
    }).catchError((error) {
      view.showNotification('Failed to delete user', isError: true);
    });
  }

  void updatePassword() {
    final updateUsernameInput =
        querySelector('#update-username-password') as InputElement?;
    final currentPasswordInput =
        querySelector('#update-current-password') as InputElement?;
    final newPasswordInput =
        querySelector('#update-new-password') as InputElement?;

    if (updateUsernameInput != null &&
        currentPasswordInput != null &&
        newPasswordInput != null) {
      String? username = updateUsernameInput.value;
      String? currentPassword = currentPasswordInput.value;
      String? newPassword = newPasswordInput.value;
      if (username != null && currentPassword != null && newPassword != null) {
        User.updatePassword(currentPassword, newPassword, username);
        view.updateUser(username);
      }
    }
  }

  void updateUsername() async {
    final updatecurrentUsername =
        querySelector('#update-current-username') as InputElement?;
    final updatenewusername =
        querySelector('#update-new-username') as InputElement?;
    final updatepasswordusername =
        querySelector('#update-password-username') as InputElement?;

    if (updatecurrentUsername != null &&
        updatenewusername != null &&
        updatepasswordusername != null) {
      String? username = updatecurrentUsername.value;
      String? newusername = updatenewusername.value;
      String? password = updatepasswordusername.value;
      if (username != null && password != null && newusername != null) {
        User.updateUsername(username, newusername, password);
      }
    }
  }
}
