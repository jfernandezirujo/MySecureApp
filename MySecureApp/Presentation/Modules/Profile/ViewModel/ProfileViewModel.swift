//
//  ProfileViewModel.swift
//  MySecureApp
//
//  Created by Julieta Fernandez Irujo on 12/05/2024.
//

import Combine
import SwiftUI

// MARK: - protocol
protocol ProfileViewModelProtocol {
  func changePassword()
  func changePasswordButtonAction()
}

// MARK: - ProfileViewModel
final class ProfileViewModel: ObservableObject, ProfileViewModelProtocol {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  @Published var credentials: CredentialsDTO
  @Published var rememberMe: Bool = false
  @Published var showAlert: Bool = false
  @Published var isShowingChangePasswordSheet: Bool = false
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
  func changePassword() {
    guard self.credentials.newPassword == self.credentials.confirmNewPassword else {
      self.showAlertSomethingWentWrong()
      return
    }
    useCaseProvider.changePassword.execute(username: credentials.username,
                                           newPassword: credentials.newPassword)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .finished:
        break
      case .failure(let error):
        self.showAlertGenericError(error: error)
      }
    }, receiveValue: { success in
      success ? self.showAlertSuccess() : self.showAlertSomethingWentWrong()
    })
    .store(in: &cancellables)
  }
  
  private func showAlert(title: String,
                         message: String,
                         buttonTitle: String) {
    showAlert = true
    alertManager.alert.title = title
    alertManager.alert.message = message
    alertManager.alert.dismissButtonTitle = buttonTitle
  }
  
  private func showAlertSuccess() {
    self.showAlert = true
    self.alertManager.showAlert(title: constants.titleGoodNews,
                                message: constants.messageChangePasswordSucceed,
                                dismissButtonTitle: constants.dismissButtonTitleOK)
  }
  
  private func showAlertSomethingWentWrong() {
    self.showAlert = true
    self.alertManager.showAlert(title: constants.titleSomethingWentWrong,
                                message: constants.messageChangePasswordFailed,
                                dismissButtonTitle: constants.dismissButtonTitleOK)
  }
  
  private func showAlertGenericError(error: Error) {
    self.showAlert = true
    self.alertManager.showAlert(title: constants.titleError,
                                message: error.localizedDescription,
                                dismissButtonTitle: constants.dismissButtonTitleOK)
  }
  
  private func setupBindings() {
    Publishers.CombineLatest(credentials.$newPassword, credentials.$confirmNewPassword)
      .map { username, password in
        username.isEmpty || password.isEmpty
      }
      .assign(to: \.credentials.areCredentialsEmpty,
              on: self)
      .store(in: &cancellables)
  }
  
  private func checkCredentials() {
    guard credentials.newPassword == credentials.confirmNewPassword else {
      self.showAlertSomethingWentWrong()
      return
    }
  }
  
  // MARK: - Methods
  func changePasswordButtonAction() {
    isShowingChangePasswordSheet = true
  }
  
  func removeNewPasswordValue() {
    credentials.newPassword = ""
  }
  
  func removeConfirmNewPasswordValue() {
    credentials.confirmNewPassword = ""
  }
  
  // MARK: - Action Methods
  func alertButtonAction() {
    self.isShowingChangePasswordSheet = false
  }
}
