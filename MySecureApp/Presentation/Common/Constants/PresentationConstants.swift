//
//  PresentationConstants.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 16/04/2024.
//

import Foundation

enum PresentationConstants {
  // Splash
  static let logo: String = "logo"
  static let initialScale: CGFloat = 0.7
  static let finalScale: CGFloat = 0.9
  static let animationDuration: TimeInterval = 0.7
  static let intervalDuration: CGFloat = 2.0
  // Textfield
  static let usernameTextField: String = "Username"
  static let passwordTextField: String = "Password"
  static let opacityTextfield: CGFloat = 0.2
  static let cornerRadius: CGFloat = 8
  // Button
  static let loginButton: String = "Login"
  static let signUpButton: String = "Sign Up"
  static let forgotPasswordButton: String = "Forgot password?"
  static let buttonTextSize: CGFloat = 20
  static let buttonFrameHeight: CGFloat = 40
  static let buttonFrameWidth: CGFloat = 220
  static let topPaddingSecondaryButton: CGFloat = 20
  static let topPaddingforgotPasswordButton: CGFloat = 10
  static let initialButtonOpacity: CGFloat = 0.5
  static let finalButtonOpacity: CGFloat = 1.0
  // NavigationBar
  static let loginTitle: String = "Welcome \nback!"
  static let signUpTitle: String = "Welcome!"
  static let backCircleSize: CGFloat = 280
  static let xOffsetCircle: CGFloat = -100
  static let xOffsetBackCircle: CGFloat = 100
  static let yOffsetCircle: CGFloat = -200
  static let xOffsetText: CGFloat = -60
  static let yOffsetText: CGFloat = -150
  static let titleFontSize: CGFloat = 56
  // LoginView
  static let verticalSpacing: CGFloat = 20
  static let horizontalPadding: CGFloat = 24
  // Alert
  static let titleSucceed: String = "Sign up succeed"
  static let messageSucceed: String = "Welcome to MySecureApp"
  
  static let titleGoodNews: String = "Good news!"
  static let messageDuplicate: String = "You already have an account"
  
  static let messageWrongCredentials: String = "Incorrect username or password"
  
  static let messageChangePasswordFailed: String = "Passwords do not match"
  
  static let messageChangePasswordSucceed: String = "Change password succeed"
  
  static let titleSomethingWentWrong: String = "Something went wrong"
  static let dismissButtonTitleRetry: String = "Retry"
  static let dismissButtonTitleGoToLogin: String = "Go to Login"
  
  static let titleError: String = "Error"
  static let dismissButtonTitleOK: String = "OK"
  // Profile
  static let profileTitle: String = "MySecureApp"
  static let helloMessage: String = "Hello, %@!"
  static let toggleTitle: String = "Remember me"
  static let togglePadding: CGFloat = 100
  static let chevronImage: String = "chevron.left"
  static let changePasswordButtonTitle: String = "Change password"
  static let newPasswordTextField: String = "New Password"
  static let confirmNewPasswordTextField: String = "Confirm Password"
  // ChangeCredentials
  static let changePasswordTitle: String = "Change password"
  static let textfieldOpacity: CGFloat = 1
}
