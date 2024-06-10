//
//  LoginViewModel.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 16/04/2024.
//

import Combine
import Foundation

// MARK: - protocol
protocol LoginViewModelProtocol {
  func primaryButtonAction()
  func alertButtonAction()
  func removePasswordValue()
  func removeUsernameValue()
}

// MARK: - LoginViewModel
final class LoginViewModel: ObservableObject, LoginViewModelProtocol {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  @Published var credentials: CredentialsDTO
  @Published var login: Bool = true
  @Published var showAlert: Bool = false
  @Published var presentProfile: Bool = false
  var alertManager: AlertManager
  private let useCaseProvider: KeychainServicesUseCaseProviderProtocol
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - init
  init(useCaseProvider: KeychainServicesUseCaseProviderProtocol,
       credentials: CredentialsDTO,
       alertManager: AlertManager) {
    self.useCaseProvider = useCaseProvider
    self.credentials = credentials
    self.alertManager = alertManager
    setupBindings()
  }
  
  // MARK: - Private methods
  private func saveCredentials()  {
    let saveCredentials: AnyPublisher<Void, Error> = useCaseProvider.saveCredentials.execute(username: credentials.username,
                                                                                             password: credentials.password)
    saveCredentials
      .sink { completion in
        switch completion {
        case .failure:
          self.showAlert = true
          self.alertManager.showAlert(title: constants.titleGoodNews,
                                      message: constants.messageDuplicate,
                                      dismissButtonTitle: constants.dismissButtonTitleGoToLogin)
        case .finished:
          break
        }
      } receiveValue: { _ in
      }
      .store(in: &cancellables)
  }
  
  private func authenticateUser() {
    let authenticateUser: AnyPublisher<Bool, Never> = useCaseProvider.authenticateUser.execute(username: credentials.username,
                                                                                               password: credentials.password)
    authenticateUser
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.showAlert = true
          self.alertManager.showAlert(title: constants.titleError,
                                      message: error.localizedDescription,
                                      dismissButtonTitle: constants.dismissButtonTitleOK)
        case .finished:
          break
        }
      } receiveValue: { isAuthenticated in
        if isAuthenticated {
          self.presentProfile.toggle()
        } else {
          self.showAlert = true
          self.alertManager.showAlert(title: constants.titleSomethingWentWrong,
                                      message: constants.messageWrongCredentials,
                                      dismissButtonTitle: constants.dismissButtonTitleRetry)
        }
      }
      .store(in: &cancellables)
  }
  
  private func checkUserExistence() {
    let checkUserExistence: AnyPublisher<Bool, Never> = useCaseProvider.checkUserExistence.execute(username: credentials.username)
    checkUserExistence
      .sink { [weak self] exists in
        guard let self: LoginViewModel = self else { return }
        if !self.login && !exists {
          self.saveCredentials()
          self.showAlert = true
          self.alertManager.showAlert(title: constants.titleSucceed,
                                      message: constants.messageSucceed,
                                      dismissButtonTitle: constants.dismissButtonTitleGoToLogin)
        } else if !self.login && exists {
          self.showAlert = true
          self.alertManager.showAlert(title: constants.titleGoodNews,
                                      message: constants.messageDuplicate,
                                      dismissButtonTitle: constants.dismissButtonTitleGoToLogin)
        }
      }
      .store(in: &cancellables)
  }
  
  private func setupBindings() {
    Publishers.CombineLatest(credentials.$username, credentials.$password)
      .map { username, password in
        username.isEmpty || password.isEmpty
      }
      .assign(to: \.credentials.areCredentialsEmpty, 
              on: self)
      .store(in: &cancellables)
  }
  
  func removePasswordValue() {
    credentials.password = ""
  }
  
  func removeUsernameValue() {
    credentials.username = ""
  }
  
  // MARK: - Action Methods
  func alertButtonAction() {
    guard !credentials.areCredentialsEmpty else { return }
    
    useCaseProvider.checkUserExistence.execute(username: credentials.username)
      .sink { [weak self] exists in
        guard let self: LoginViewModel = self else { return }
        if (!self.login && !exists) || (!self.login && exists) {
          self.login.toggle()
          self.removePasswordValue()
          self.removeUsernameValue()
        }
      }
      .store(in: &cancellables)
  }
  
  func primaryButtonAction() {
    if login {
      authenticateUser()
    } else {
      checkUserExistence()
    }
  }
}
