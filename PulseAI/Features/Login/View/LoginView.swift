//
//  LoginView.swift
//  PulseAI
//
//  Created by Meet Brahmbhatt on 29/08/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @ObservedObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 16, content: {
                    Spacer()
                    Text("Login")
                        .font(.largeTitle).bold()

                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .accessibilityIdentifier("Email")

                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .accessibilityIdentifier("Password")

                    if viewModel.isLoading {
                        ProgressView()
                    }

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button(action: {
                        hideKeyboard()
                        viewModel.login()
                    }, label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }).accessibilityIdentifier("Login")

                    Spacer()

                    NavigationLink(destination: Text("Home Screen").accessibilityIdentifier("Home Screen"), isActive: $viewModel.isLoggedIn) {
                        EmptyView()
                    }
                })
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .animation(.easeOut, value: 0.25)
            }
        }
        .accessibilityIdentifier("BackgroundView")
        .onTapGesture {
            hideKeyboard()
        }
    }
}
