//
//  CustomGradientBackground.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 13/05/2024.
//

import SwiftUI

struct CustomGradientBackground: View {
  
  // MARK: - body
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [.customLightBlue, .white]),
                   startPoint: .top,
                   endPoint: .bottom)
    .edgesIgnoringSafeArea(.all)
  }
}
