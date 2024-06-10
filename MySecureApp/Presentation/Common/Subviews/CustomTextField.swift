//
//  CustomTextField.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/05/2024.
//

import SwiftUI

struct CustomTextField: View {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  let title: String
  var text: Binding<String>
  var backgroundColor: Color
  var textFieldoOacity: Double
  let action: () -> Void
  
  // MARK: - init
  init(title: String,
       text: Binding<String>,
       backgroundColor: Color = Color.gray,
       textFieldoOacity: Double = constants.opacityTextfield,
       action: @escaping () -> Void) {
    self.title = title
    self.text = text
    self.backgroundColor = backgroundColor
    self.textFieldoOacity = textFieldoOacity
    self.action = action
  }
  
  // MARK: - body
  var body: some View {
    TextField(title, text: text)
      .textInputAutocapitalization(.never)
      .padding()
      .background(backgroundColor.opacity(textFieldoOacity))
      .cornerRadius(constants.cornerRadius)
      .onAppear {
        action()
      }
  }
}
