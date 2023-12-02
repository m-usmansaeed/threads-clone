//
//  ProfileEditAndShareButton.swift
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

struct ProfileEditAndShareButton: View {
    
    @State private var showingSheet = false
    @ObservedObject var viewModel: CurrentUserProfileViewModel

    var body: some View {

        HStack(alignment: .center, spacing: 8) {
            Button {
                showingSheet.toggle()
            } label: {
                Text("Edit Profile")
                    .font(Font.subheadline.weight(.semibold))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width / 2 - 16, height: 32)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
            }
            .sheet(isPresented: $showingSheet) {
                EditProfileView(size: .medium).environmentObject(viewModel)
            }
            
            Button {
                
            } label: {
                Text("Share Profile")
                    .font(Font.subheadline.weight(.semibold))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width / 2 - 16, height: 32)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
            }
        }
    }
}

struct ProfileEditAndShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditAndShareButton(viewModel: CurrentUserProfileViewModel())
    }
}
