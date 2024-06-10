//
//  CustomButton.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 14/05/2024.
//

import SwiftUI

struct CustomButton: View {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  let action: () -> Void
  let title: String
  var backgroundColor: Color?
  var opacity: CGFloat?
  var isDisabled: Bool?
  
  // MARK: - init
  init(action: @escaping () -> Void,
       title: String,
       background: Color? = Color.customLightPurple,
       opacity: CGFloat? = constants.finalButtonOpacity,
       isDisabled: Bool? = false) {
    self.action = action
    self.title = title
    self.backgroundColor = background
    self.opacity = opacity
    self.isDisabled = isDisabled
  }
  
  // MARK: - body
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: constants.buttonTextSize))
        .font(.headline)
        .frame(width: constants.buttonFrameWidth,
               height: constants.buttonFrameHeight)
        .foregroundColor(.white)
        .background(backgroundColor)
        .cornerRadius(constants.cornerRadius)
        .opacity(opacity ?? constants.finalButtonOpacity)
    }
    .disabled(isDisabled ?? false)
  }
}
