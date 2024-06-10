//
//  AuthenticateUserUseCase.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine

// MARK: - protocol
protocol AuthenticateUserUseCaseProtocol {
  func execute(username: String, 
               password: String) -> AnyPublisher<Bool, Never>
}

// MARK: - AuthenticateUserUseCase
class AuthenticateUserUseCase: AuthenticateUserUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: AuthenticateUserRepositoryProtocol
  
  // MARK: - init
  init(repository: AuthenticateUserRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute(username: String, 
               password: String) -> AnyPublisher<Bool, Never> {
    repository.authenticateUser(username: username,
                                password: password)
    .eraseToAnyPublisher()
  }
}
