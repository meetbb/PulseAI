//
//  LoginViewModel.swift
//  PulseAI
//
//  Created by Meet Brahmbhatt on 29/08/25.
//

import Foundation
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Email Validation
    func isValidEmail(_ email: String) -> Bool {
        // RFC 5322 compliant regex (simplified)
        let emailRegEx =
            "(?:[a-zA-Z0-9._%+-]+)@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,64}"

        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password must not be empty!"
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            return
        }

        isLoading = true
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.isLoggedIn = true
                }
            }
        }
    }
}
