//
//  CredentialsDTO.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 02/05/2024.
//

import Combine

class CredentialsDTO {
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var newPassword: String = ""
  @Published var confirmNewPassword: String = ""
  @Published var areCredentialsEmpty: Bool = true
}
