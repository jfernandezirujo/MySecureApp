//
//  ChangeCredentialsView.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 12/05/2024.
//

import SwiftUI

struct ChangeCredentialsView: View {
  
  // MARK: - Properties
  @EnvironmentObject private var viewModel: ProfileViewModel
  typealias constants = PresentationConstants
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      ZStack {
        CustomGradientBackground()
        VStack {
          VStack {
            passwordTextfield
            confirmationTextfield
          }
          .padding(.horizontal, constants.horizontalPadding)
          primaryButton
        }
      }.onAppear {
        viewModel.removeNewPasswordValue()
        viewModel.removeConfirmNewPasswordValue()
        DispatchQueue.main.async {
            viewModel.objectWillChange.send()
        }
      }
      .navigationTitle(constants.changePasswordTitle)
    }.alert(isPresented: $viewModel.showAlert) {
      Alert(title: Text(viewModel.alertManager.alert.title),
            message: Text(viewModel.alertManager.alert.message),
            dismissButton: .default(Text(viewModel.alertManager.alert.dismissButtonTitle)) {
        viewModel.alertButtonAction()
      }
      )
    }

  }
  
  // MARK: - Subviews
  private var passwordTextfield: some View {
    CustomTextField(title: constants.newPasswordTextField,
                    text: $viewModel.credentials.newPassword,
                    backgroundColor: .white,
                    textFieldoOacity: constants.textfieldOpacity,
                    action: {
      viewModel.removeNewPasswordValue()
    })
  }
  
  private var confirmationTextfield: some View {
    CustomTextField(title: constants.confirmNewPasswordTextField,
                    text: $viewModel.credentials.confirmNewPassword,
                    backgroundColor: .white,
                    textFieldoOacity: constants.textfieldOpacity,
                    action: {
      viewModel.removeConfirmNewPasswordValue()
    })
  }
  
  private var primaryButton: some View {
    CustomButton(action: {
      viewModel.changePassword()
    },
                 title: constants.changePasswordTitle,
                 opacity: viewModel.credentials.areCredentialsEmpty ? constants.initialButtonOpacity : constants.finalButtonOpacity,
                 isDisabled: viewModel.credentials.areCredentialsEmpty)
    .padding(.top, constants.verticalSpacing)
  }
}
