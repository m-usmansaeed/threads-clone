//
//  LoginView.swift
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

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        
        ZStack {
            
//            if user.isLoggedIn {
//                ThreadsTabbarView()
//            }else{
                NavigationView {
                    VStack {
                        
                        Spacer()
                        Image("threadsIcon").modifier(TheadLogoModifire())
                        
                        VStack {
                            TextField("Enter your email:", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .modifier(TextfieldModifiers())
                            SecureField("Enter your password:", text: $viewModel.password)
                                .modifier(TextfieldModifiers())
                        }
                        
                        NavigationLink {
                            Text("Forgot password")
                        } label: {
                            Text("Forgot password")
                                .font(Font.footnote.weight(.semibold))
                                .padding(.vertical)
                                .padding(.trailing, 28)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        Button {
//                            user.isLoggedIn = true
                            
                            Task {
                                try await viewModel.login()
                            }
                            
                        } label: {
                            Text("Login").modifier(AuthMainButtonModifier())
                        }
                        
                        Spacer()
                        Divider()
                        
                        NavigationLink {
                            
                            SignUpView()
                                .navigationBarBackButtonHidden(true)
                            
                        } label: {
                            HStack(spacing: 3) {
                                Text("Don't have an account?")
                                Text("Sign Up")
                                    .font(Font.footnote.weight(.semibold))
                            }
                            .foregroundStyle(.black)
                            .font(.footnote)
                        }.padding(.vertical, 16)
                        
                    }
                }

//            }
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
    LoginView()
    }
}
