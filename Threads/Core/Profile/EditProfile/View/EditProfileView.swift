//
//  EditProfileView.swift
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

struct EditProfileView: View {
    
    @State var bioText = ""
    @State var link = ""
    @State var isPrivate = false
    @Environment(\.dismiss) var dismiss
    
    @StateObject var userVM = CurrentUserProfileViewModel()
    @StateObject var viewModel = EditProfileViewModel()
    let size: ProfileImageSize

    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea(edges: [.bottom, .horizontal])
                
                VStack(spacing: 16) {
                    NameAndProfileImage(user: userVM.currentUser!, size: size, viewModel: viewModel, isEditing: true)
                    
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Bio")
                        TextField("Enter your bio", text: $bioText)
                    }.font(.footnote)
                    
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Link")
                        TextField("Add link...", text: $link)
                    }.font(.footnote)
                    
                    Divider()
                    Toggle("Private Profile", isOn: $isPrivate).font(.footnote)
                    
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
                
                
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button("Done"){
                        
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                        
//
                    }
                    .font(Font.subheadline.weight(.semibold))
                    .foregroundColor(Color.black)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(size: .small)
    }
}
