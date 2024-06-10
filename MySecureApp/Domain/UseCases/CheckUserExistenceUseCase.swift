//
//  CheckUserExistenceUseCase.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine

// MARK: - protocol
protocol CheckUserExistenceUseCaseProtocol {
  func execute(username: String) -> AnyPublisher<Bool, Never>
}

// MARK: - CheckUserExistenceUseCase
class CheckUserExistenceUseCase: CheckUserExistenceUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: CheckUserExistenceRepositoryProtocol
  
  // MARK: - init
  init(repository: CheckUserExistenceRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute(username: String) -> AnyPublisher<Bool, Never> {
    repository.checkUserExistence(username: username)
  }
}
