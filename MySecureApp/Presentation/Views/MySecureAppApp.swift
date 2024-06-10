//
//  MySecureAppApp.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 15/04/2024.
//

import SwiftUI

@main
struct MySecureAppApp: App {
  
  // MARK: - Properties
  private let dependencies: AppDependencies
  private let loginViewModel: LoginViewModel
  private let profileViewModel: ProfileViewModel
  
  // MARK: - init
  init() {
    self.dependencies = AppDependencies()
    self.loginViewModel = dependencies.setLoginViewModel()
    self.profileViewModel = dependencies.setProfileViewModel()
  }
  
  // MARK: - body
  var body: some Scene {
    WindowGroup {
      ViewCoordinator()
        .environmentObject(loginViewModel)
        .environmentObject(profileViewModel)
    }
  }
}
