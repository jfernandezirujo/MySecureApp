//
//  SplashView.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 15/04/2024.
//

import SwiftUI

struct SplashView: View {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  @Binding var isActive: Bool
  @State private var scale = constants.initialScale
  private let animationDuration: TimeInterval = constants.animationDuration
  private let intervalDuration: TimeInterval = constants.intervalDuration
  
  // MARK: - body
  var body: some View {
    VStack {
      Image(constants.logo)
        .resizable()
        .scaledToFit()
        .scaleEffect(scale)
        .onAppear{
          withAnimation(.easeIn(duration: animationDuration)) {
            self.scale = constants.finalScale
          }
        }
    }.onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + constants.intervalDuration) {
        withAnimation {
          self.isActive = true
        }
      }
    }
  }
}
