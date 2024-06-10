//
//  ViewCoordinator.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 16/04/2024.
//

import SwiftUI

struct ViewCoordinator: View {
  
  // MARK: - Properties
  @State private var isActive = false
  @State private var isLoggedIn = false
  
  // MARK: - body
  var body: some View {
    if isActive {
      if isLoggedIn {
        ProfileView()
      } else {
        LoginView()
      }
    }else {
      SplashView(isActive: $isActive)
    }
  }
}
