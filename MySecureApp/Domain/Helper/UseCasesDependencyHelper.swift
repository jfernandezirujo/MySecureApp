//
//  DependencyHelper.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

class UseCasesDependencyHelper {
  
  // MARK: - Methods
  static func getSaveCredentialsUseCase() -> SaveCredentialsUseCaseProtocol {
    let saveCredentialsRepository: SaveCredentialsRepositoryProtocol = SaveCredentialsRepository()
    return SaveCredentialsUseCase(repository: saveCredentialsRepository)
  }
  
  static func getAuthenticateUserUseCase() -> AuthenticateUserUseCaseProtocol {
    let authenticateUserRepository: AuthenticateUserRepositoryProtocol = AuthenticateUserRepository()
    return AuthenticateUserUseCase(repository: authenticateUserRepository)
  }
  
  static func getCheckUserExistenceUseCase() -> CheckUserExistenceUseCaseProtocol {
    let checkUserExistenceRepository: CheckUserExistenceRepositoryProtocol = CheckUserExistenceRepository()
    return CheckUserExistenceUseCase(repository: checkUserExistenceRepository)
  }
  
  static func getChangePasswordUseCase() -> ChangePasswordUseCaseProtocol {
    let changePasswordRepository: ChangePasswordRepositoryProtocol = ChangePasswordRepository()
    return ChangePasswordUseCase(repository: changePasswordRepository)
  }
}
