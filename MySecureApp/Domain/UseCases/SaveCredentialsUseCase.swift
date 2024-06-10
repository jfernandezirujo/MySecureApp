//
//  SaveCredentialsUseCase.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine

// MARK: - protocol
protocol SaveCredentialsUseCaseProtocol {
  func execute(username: String,
               password: String) -> AnyPublisher<Void, Error>
}

// MARK: - SaveCredentialsUseCase
class SaveCredentialsUseCase: SaveCredentialsUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: SaveCredentialsRepositoryProtocol
  
  // MARK: - init
  init(repository: SaveCredentialsRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute(username: String, 
               password: String) -> AnyPublisher<Void, Error> {
    repository.saveCredentials(username: username,
                               password: password)
  }
}
