//
//  AuthenticateUserRepository.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine
import Foundation

// MARK: - protocol
protocol AuthenticateUserRepositoryProtocol {
  func authenticateUser(username: String,
                        password: String) -> AnyPublisher<Bool, Never>
}

// MARK: - AuthenticateUserRepository
class AuthenticateUserRepository: AuthenticateUserRepositoryProtocol {
  
  // MARK: - Methods
  func authenticateUser(username: String,
                        password: String) -> AnyPublisher<Bool, Never> {
    return Future<Bool, Never> { promise in
      guard !password.isEmpty else {
        promise(.success(false))
        return
      }
      
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecReturnData as String: kCFBooleanTrue!,
        kSecMatchLimit as String: kSecMatchLimitOne
      ]
      
      var retrievedPassword: AnyObject?
      let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &retrievedPassword)
      
      guard status == errSecSuccess,
            let passwordData: Data = retrievedPassword as? Data,
            let retrievedPasswordString: String = String(data: passwordData, encoding: .utf8) else {
        promise(.success(false))
        return
      }
      
      promise(.success(retrievedPasswordString == password))
    }
    .eraseToAnyPublisher()
  }
}
