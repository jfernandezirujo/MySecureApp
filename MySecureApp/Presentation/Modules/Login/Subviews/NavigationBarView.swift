//
//  NavigationBarView.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 17/04/2024.
//

import SwiftUI

struct NavigationBarView: View {

  // MARK: - Properties
  typealias constants = PresentationConstants
  @Binding var login: Bool

  // MARK: - body
  var body: some View {
    ZStack {
      backCircle
      frontCircle
      title
    }
  }

  // MARK: - Subviews
  private var frontCircle: some View {
    Circle()
      .foregroundColor(login ? Color.customLightBlue : Color.customLightPurple)
      .offset(x: safeOffset(constants.xOffsetCircle),
              y: safeOffset(constants.yOffsetCircle))
  }

  private var backCircle: some View {
    Circle()
      .frame(width: constants.backCircleSize)
      .foregroundColor(login ? Color.customLightPurple : Color.customLightBlue)
      .offset(x: safeOffset(constants.xOffsetBackCircle),
              y: safeOffset(constants.yOffsetCircle))
  }

  private var title: some View {
    Text(login ? constants.loginTitle : constants.signUpTitle)
      .offset(x: safeOffset(constants.xOffsetText),
              y: safeOffset(constants.yOffsetText))
      .font(.system(size: constants.titleFontSize))
      .foregroundColor(.white)
  }

  // MARK: - Helper Functions
  private func safeOffset(_ value: CGFloat) -> CGFloat {
    if value.isNaN || value.isInfinite {
      return 0
    }
    return value
  }
}
