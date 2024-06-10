//
//  SecondaryButtonView.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 17/04/2024.
//

import SwiftUI

struct SecondaryButtonView: View {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  @EnvironmentObject private var viewModel: LoginViewModel
  
  // MARK: - body
  var body: some View {
    Button(action: {
      viewModel.login.toggle()
      viewModel.removePasswordValue()
      viewModel.removeUsernameValue()
    },
           label: {
      Text(!viewModel.login ? constants.loginButton : constants.signUpButton)
        .foregroundStyle(.gray)
    })
    .padding(.top, constants.topPaddingSecondaryButton)
  }
}
