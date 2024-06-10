//
//  AlertManager.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 11/05/2024.
//

import SwiftUI

class AlertManager: ObservableObject {
  
  // MARK: - Properties
  @Published var alert: AlertDTO = AlertDTO()
  
  // MARK: - Methods
  func showAlert(title: String,
                 message: String,
                 dismissButtonTitle: String) {
    self.alert.title = title
    self.alert.message = message
    self.alert.dismissButtonTitle = dismissButtonTitle
  }
}
