//
//  LoginView.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 16/04/2024.
//

import SwiftUI

struct LoginView: View {
  
  // MARK: - Properties
  @EnvironmentObject private var viewModel: LoginViewModel
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      ZStack {
        navigationBar
        VStack {
          textfieldItems
          primaryButtonView
          SecondaryButtonView()
        }
      }
      .alert(isPresented: $viewModel.showAlert) {
        Alert(title: Text(viewModel.alertManager.alert.title),
              message: Text(viewModel.alertManager.alert.message),
              dismissButton: .default(Text(viewModel.alertManager.alert.dismissButtonTitle)) {
          viewModel.alertButtonAction()
        }
        )
      }
      .navigationDestination(isPresented: $viewModel.presentProfile,
                             destination: {
        ProfileView()
      })
      .ignoresSafeArea(.keyboard)
    }
  }
  
  // MARK: - Subviews
  private var navigationBar: some View {
    VStack {
      NavigationBarView(login: $viewModel.login)
      Spacer()
    }
  }
  
  private var textfieldItems: some View {
    VStack {
      usernameTextfield
      PasswordTextField()
    }
    .padding(.horizontal, LoginViewModel.constants.horizontalPadding)
  }
  
  private var usernameTextfield: some View {
    CustomTextField(title: LoginViewModel.constants.usernameTextField,
                    text: $viewModel.credentials.username,
                    action: {
      viewModel.removeUsernameValue()
    })
  }
  
  private var primaryButtonView: some View {
    CustomButton(action: {
      viewModel.primaryButtonAction()
    },
                 title: viewModel.login ? LoginViewModel.constants.loginButton : LoginViewModel.constants.signUpButton,
                 background: viewModel.login ? Color.customLightPurple : Color.customLightBlue,
                 opacity: viewModel.credentials.areCredentialsEmpty ? LoginViewModel.constants.initialButtonOpacity : LoginViewModel.constants.finalButtonOpacity,
                 isDisabled: viewModel.credentials.areCredentialsEmpty
    )
    .padding(.top, LoginViewModel.constants.verticalSpacing)
  }
}
