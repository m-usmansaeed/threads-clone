//
//  AuthService.swift
//  Threads
//
//  Copyright (c) Muhammad Usman Saeed
//
//  Using xCode 12.3, Swift 5.0
//  Running on macOS 12.6
//  Created on 12/2/23
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Firebase
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, 
               password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(
                withEmail: email,
                password: password)
            print("DEBUG: Create user \(result.user.uid)")
            self.userSession = result.user
//            UserService.shared.currentUser = result.user
        } catch {
            print("DEBUG: Something went wrong \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signup(withEmail email: String,
               password: String,
               fullname: String,
               username: String) async throws {
        
        do {
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: password)
            self.userSession = result.user
            try await self.uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)
            print("DEBUG: Create user \(result.user.uid)")
        } catch {
            print("DEBUG: Something went wrong \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
         try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.resetUser()
    }
    
    @MainActor
    func uploadUserData(withEmail email: String,
                        fullname: String,
                        username: String,
                        id: String) async throws {
        
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
    
    
}
