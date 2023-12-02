//
//  NameAndProfileImage.swift
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
import PhotosUI

struct NameAndProfileImage: View {
    
    let user: User?
    let size: ProfileImageSize
    @ObservedObject var viewModel: EditProfileViewModel
    @State var showImagePicker: Bool = false
    let isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                UsernameView(fullname: user?.fullname ?? "", username: user?.username ?? "")
                Spacer()
                
                ZStack {
                    if let image = viewModel.profileImage {
                        image.modifier(CircularImage(size: size))
                    }else{
                        CircularProfileImageView(user: user, size: size)
                    }
                }.onTapGesture {
                    print("tapped ")
                    if isEditing {
                        self.showImagePicker.toggle()
                    }
                }
                //                PhotosPicker(selection: $viewModel.selectedItem) {
                //                    if let image = viewModel.profileImage {
                //                        image.modifier(CircularImage(size: size))
                //                    }else{
                //                        CircularProfileImageView(user: user, size: size)
                //                    }
                //                }
                
            }
        }.sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                viewModel.uiImage = image
            }
        }
    }
}

struct UsernameView : View {
    
    let fullname: String
    let username: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(fullname)
                .font(Font.title2.weight(.semibold))
            
            Text(username)
                .font(.subheadline)
        }
    }
}


struct NameAndProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        NameAndProfileImage(user: User.sampleUser, size: .small, viewModel: EditProfileViewModel(), isEditing: false)
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView(fullname: "Usman Saeed", username: "usman-saeed")
    }
}
