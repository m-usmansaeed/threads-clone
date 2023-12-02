//
//  NewThreadView.swift
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

struct NewThreadView: View {
        
    @StateObject var viewModel = NewThreadViewModel()
    @Binding var isShowingNewThreadView: Bool
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    @State var caption = ""//"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: user, size: .small)
//                    Image("testImage").modifier(CircularImage())

                    VStack(alignment: .leading, spacing: 0) {
                        Text(user?.username ?? "")
                            .font(Font.footnote.weight(.semibold))
//                        TextField("What's in your mind", text: $viewModel.caption, axis: .vertical)
                        TextEditorWithPlaceholder(text: $viewModel.caption)
                    }
                    
                    if !viewModel.caption.isEmpty {
                        Button {
                            viewModel.caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isShowingNewThreadView = false
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        
                        Task {
                            try await viewModel.uploadThread()
                        }
                        isShowingNewThreadView = false
                    }
                    .opacity(viewModel.caption.isEmpty ? 0.5 : 1.0)
                    .disabled(viewModel.caption.isEmpty)
                    .font(Font.subheadline.weight(.semibold))
                    .foregroundColor(Color.black)
                }
            }
        }
    }
}

struct NewThreadView_Previews: PreviewProvider {
    static var previews: some View {
        NewThreadView(isShowingNewThreadView: .constant(true))
    }
}
