import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;

  static bool get isSignIn => _firebaseAuth.currentUser != null;

  static User get currentUser => _firebaseAuth.currentUser!;

  Future<User> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw 'Login failed';
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Email or password is incorrect.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (_) {
      rethrow;
    }
  }

  Future<void> passwordChangeValidation(
    String newPassword,
    String oldPassword,
  ) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: oldPassword,
      );
      try {
        final check =
            await currentUser.reauthenticateWithCredential(credential);
        if (check.user != null) {
          await _firebaseAuth.currentUser!.updatePassword(newPassword);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          throw 'Old password did not match';
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      await _firebaseAuth.signOut();
    } catch (_) {}
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (r) {
      if (r.code == 'invalid-email') {
        throw 'Invalid Email Entered';
      } else if (r.code == 'user-not-found') {
        throw 'Account with this email not exists.';
      }
      throw r.message ?? 'Internet Connection error';
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signUp(String email, String password) async {
    try {
      await signOut();
      final createdUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (createdUser.user == null) {
        throw 'Login failed';
      }
      return createdUser.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    try {
      await signOut();
      final account = await GoogleSignIn().signIn();
      if (account == null) {
        throw 'Google login failed';
      }
      final authentication = await account.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final authResult = await FirebaseAuth.instance.signInWithCredential(
        authCredential,
      );
      return authResult;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw 'Account with this email already exists';
      }
      throw e.code;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithFacebook() async {
    try {
      await signOut();
      final loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      switch (loginResult.status) {
        case LoginStatus.success:
          if (loginResult.accessToken == null) {
            throw 'Facebook login failed';
          }
          final credentials = FacebookAuthProvider.credential(
            loginResult.accessToken!.token,
          );
          return await _firebaseAuth.signInWithCredential(credentials);
        case LoginStatus.cancelled:
          throw 'User has cancelled the login';
        case LoginStatus.failed:
          throw loginResult.message ?? 'Facebook login failed';
        case LoginStatus.operationInProgress:
          throw loginResult.message ?? 'Login in progress';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw 'Account with this email already exists';
      }
      throw e.code;
    } catch (_) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithApple() async {
    try {
      await signOut();
      final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredentials.identityToken,
        accessToken: appleCredentials.authorizationCode,
      );
      final authResult = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      if (authResult.user == null) {
        throw 'Apple login failed';
      }
      return authResult;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw'Account with this email already exists';
      }
      throw e.code;
    } catch (e) {
      throw 'Apple authorization cancelled';
    }
  }
}
