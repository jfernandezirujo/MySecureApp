//
//  PasswordTextField.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 17/04/2024.
//

import SwiftUI

struct PasswordTextField: View {

  // MARK: - Properties
  typealias constants = PresentationConstants
  @EnvironmentObject private var viewModel: LoginViewModel

  // MARK: - body
  var body: some View {
    SecureField(constants.passwordTextField, text: $viewModel.credentials.password)
      .textContentType(.password)
      .padding()
      .background(Color.gray.opacity(constants.opacityTextfield))
      .cornerRadius(constants.cornerRadius)
      .onAppear {
        viewModel.credentials.password = ""
      }
  }
}
