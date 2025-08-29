//
//  PulseAIApp.swift
//  PulseAI
//
//  Created by Meet Brahmbhatt on 29/08/25.
//

import SwiftUI
import Firebase

@main
struct PulseAIApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
