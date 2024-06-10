//
//  ChangePasswordRepository.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine
import Foundation
import Security

// MARK: - protocol
protocol ChangePasswordRepositoryProtocol {
  func changePassword(username: String,
                      newPassword: String) -> AnyPublisher<Bool, Never>
}

// MARK: - ChangePasswordRepository
class ChangePasswordRepository: ChangePasswordRepositoryProtocol {
  
  // MARK: - Methods
  func changePassword(username: String,
                      newPassword: String) -> AnyPublisher<Bool, Never> {
    
    return Future<Bool, Never> { promise in
      guard !username.isEmpty && !newPassword.isEmpty else {
        promise(.success(false))
        return
      }
      guard let usernameData: Data = username.data(using: .utf8),
            let newPasswordData: Data = newPassword.data(using: .utf8) else {
        promise(.success(false))
        return
      }
      
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: usernameData
      ]
      
      let attributes: [String: Any] = [
        kSecValueData as String: newPasswordData
      ]
      
      let status: OSStatus = SecItemUpdate(query as CFDictionary, 
                                           attributes as CFDictionary)
      promise(.success(status == errSecSuccess))
    }
    .eraseToAnyPublisher()
  }
}
