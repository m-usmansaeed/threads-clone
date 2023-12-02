//
//  CurrentProfileView.swift
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

struct CurrentProfileView: View {
    
    @StateObject var userVM = CurrentUserProfileViewModel()
    @StateObject var viewModel = EditProfileViewModel()
    
    private var currentUser: User? {
        userVM.currentUser
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                //            Bio and stats view
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        NameAndProfileImage(user: userVM.currentUser, size: .medium, viewModel: viewModel, isEditing: false)
                        
                        if let bio = currentUser?.bio {
                            Text(bio)
                                .font(.footnote)
                        }
                        
                        Text("2 followers")
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                    
                    ProfileEditAndShareButton(viewModel: userVM)
                    //                        .environmentObject(viewModel)
                    //                User content list view
                    ProfileViewTabs(user: currentUser ?? User.sampleUser)
                    
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
            
        }
    }
    
}

struct CurrentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentProfileView()
    }
}
