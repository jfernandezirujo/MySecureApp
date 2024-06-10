//
//  KeychainServicesUseCaseProvider.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 25/04/2024.
//

// MARK: - protocol
protocol KeychainServicesUseCaseProviderProtocol {
  var saveCredentials: SaveCredentialsUseCaseProtocol { get }
  var authenticateUser: AuthenticateUserUseCaseProtocol { get }
  var checkUserExistence: CheckUserExistenceUseCaseProtocol { get }
  var changePassword: ChangePasswordUseCaseProtocol { get }
}

// MARK: - KeychainServicesUseCaseProvider
final class KeychainServicesUseCaseProvider: KeychainServicesUseCaseProviderProtocol {
  
  // MARK: - Properties
  internal var saveCredentials: SaveCredentialsUseCaseProtocol
  internal var authenticateUser: AuthenticateUserUseCaseProtocol
  internal var checkUserExistence: CheckUserExistenceUseCaseProtocol
  internal var changePassword: ChangePasswordUseCaseProtocol
  
  // MARK: - init
  init(saveCredentials: SaveCredentialsUseCaseProtocol,
       authenticateUser: AuthenticateUserUseCaseProtocol,
       checkUserExistence: CheckUserExistenceUseCaseProtocol,
       changePassword: ChangePasswordUseCaseProtocol) {
    self.saveCredentials = saveCredentials
    self.authenticateUser = authenticateUser
    self.checkUserExistence = checkUserExistence
    self.changePassword = changePassword
  }
  
  // MARK: - lazy properties
  lazy var saveCredentialsRepository: SaveCredentialsRepositoryProtocol = {
    return SaveCredentialsRepository()
  }()
  
  lazy var authenticateUserRepository: AuthenticateUserRepositoryProtocol = {
    return AuthenticateUserRepository()
  }()
  
  lazy var checkUserExistenceRepository: CheckUserExistenceRepositoryProtocol = {
    return CheckUserExistenceRepository()
  }()
  
  lazy var changePasswordRepository: ChangePasswordRepositoryProtocol = {
    return ChangePasswordRepository()
  }()
  
  // MARK: - Methods
  func provideSaveCredentialsUseCase() -> SaveCredentialsUseCaseProtocol {
    return SaveCredentialsUseCase(repository: saveCredentialsRepository)
  }
  
  func provideAuthenticateUserUseCase() -> AuthenticateUserUseCaseProtocol {
    return AuthenticateUserUseCase(repository: authenticateUserRepository)
  }
  
  func provideCheckUserExistenceUseCase() -> CheckUserExistenceUseCaseProtocol {
    return CheckUserExistenceUseCase(repository: checkUserExistenceRepository)
  }
  
  func provideChangePasswordUseCase() -> ChangePasswordUseCaseProtocol {
    return ChangePasswordUseCase(repository: changePasswordRepository)
  }
}
