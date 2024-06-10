//
//  ChangePasswordUseCase.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

import Combine

// MARK: - protocol
protocol ChangePasswordUseCaseProtocol {
  func execute(username: String, 
               newPassword: String) -> AnyPublisher<Bool, Never>
}

// MARK: - ChangePasswordUseCase
class ChangePasswordUseCase: ChangePasswordUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: ChangePasswordRepositoryProtocol
  
  // MARK: - init
  init(repository: ChangePasswordRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute(username: String, 
               newPassword: String) -> AnyPublisher<Bool, Never> {
    repository.changePassword(username: username,
                              newPassword: newPassword)
  }
}
