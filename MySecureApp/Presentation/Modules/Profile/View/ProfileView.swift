//
//  ProfileView.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 24/04/2024.
//

import SwiftUI

struct ProfileView: View {
  
  // MARK: - Properties
  @EnvironmentObject private var viewModel: ProfileViewModel
  typealias constants = PresentationConstants
  @Environment(\.presentationMode) private var presentationMode
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      ZStack {
        CustomGradientBackground()
        VStack {
          greetingsText
          primaryButtonView
        }
      }
    }
    .navigationBarTitle(constants.profileTitle, displayMode: .large)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: constants.chevronImage)
            .foregroundStyle(.black)
        }
      }
    }
    .sheet(isPresented: $viewModel.isShowingChangePasswordSheet) {
      ChangeCredentialsView()
        .padding()
    }
  }
  
  // MARK: - Subview
  var greetingsText: some View {
    Text(String(format: constants.helloMessage, viewModel.credentials.username))
      .fontDesign(.monospaced)
      .font(.system(size: constants.titleFontSize))
  }
  
  var toggleItem: some View {
    Toggle(constants.toggleTitle, isOn: $viewModel.rememberMe)
      .tint(.customLightPurple)
      .padding(constants.togglePadding)
  }
  
  var primaryButtonView: some View {
    CustomButton(action: {
      viewModel.changePasswordButtonAction()
    },
                 title: constants.changePasswordButtonTitle)
    .padding(.top, constants.verticalSpacing)
  }
}
