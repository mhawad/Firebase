//
//  FirebaseTestApp.swift
//  Shared
//
//  Created by Mirna Sokar on 6/9/22.
//

import SwiftUI
import Firebase

@main
struct FirebaseTestApp: App {
    
    init() {
        
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
