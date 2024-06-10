//
//  SaveCredentialsRepository.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine
import Foundation

// MARK: - protocol
protocol SaveCredentialsRepositoryProtocol {
  func saveCredentials(username: String,
                       password: String) -> AnyPublisher<Void, Error> 
}

// MARK: - SaveCredentialsRepository
class SaveCredentialsRepository: SaveCredentialsRepositoryProtocol {
  
  // MARK: - Methods
  func saveCredentials(username: String,
                       password: String) -> AnyPublisher<Void, Error> {
    
    return Future<Void, Error> { promise in
      guard !username.isEmpty && !password.isEmpty else {
        promise(.failure(CredentialError.emptyCredentials))
        return
      }
      guard let usernameData: Data = username.data(using: .utf8),
            let passwordData: Data = password.data(using: .utf8) else {
        promise(.failure(CredentialError.invalidData))
        return
      }
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: usernameData,
        kSecValueData as String: passwordData
      ]
      let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
      
      if status == errSecSuccess {
        promise(.success(()))
      } else {
        promise(.failure(CredentialError.keychainError(status)))
      }
    }
    .eraseToAnyPublisher()
  }
}

enum CredentialError: Error {
  case emptyCredentials
  case invalidData
  case keychainError(OSStatus)
}
