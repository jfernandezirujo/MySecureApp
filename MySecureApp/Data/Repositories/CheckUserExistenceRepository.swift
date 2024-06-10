//
//  CheckUserExistenceRepository.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine
import Foundation
import Security

// MARK: - protocol
protocol CheckUserExistenceRepositoryProtocol {
  func checkUserExistence(username: String) -> AnyPublisher<Bool, Never>
}

// MARK: - CheckUserExistenceRepository
class CheckUserExistenceRepository: CheckUserExistenceRepositoryProtocol {
  
  func checkUserExistence(username: String) -> AnyPublisher<Bool, Never> {
    return Future<Bool, Never> { promise in
      guard !username.isEmpty else {
        promise(.success(false))
        return
      }
      
      guard let usernameData: Data = username.data(using: .utf8) else {
        promise(.success(false))
        return
      }
      
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: usernameData,
        kSecReturnAttributes as String: kCFBooleanTrue!,
        kSecMatchLimit as String: kSecMatchLimitOne
      ]
      
      var result: AnyObject?
      let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)
      
      promise(.success(status == errSecSuccess))
    }
    .eraseToAnyPublisher()
  }
}
