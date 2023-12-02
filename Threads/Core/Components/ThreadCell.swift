//
//  ThreadCell.swift
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

struct ThreadCell: View {
    
    let thread: Thread
    
    var body: some View {
        VStack {

            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 2) {
                    CircularProfileImageView(user: thread.user, size: .small)
                    Color.gray
                        .frame(maxWidth: 0.4, maxHeight: .infinity)
//                        .rotationEffect(.degrees(-90))
                    LikesView(thread: thread, likesCount: .three)

                    
                    //                Image("testImage").modifier(CircularImage())
                }
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(Font.footnote.weight(.semibold))
                        Spacer()
                        
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {} label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
//                    Bar Buttons
                    HStack(spacing:16) {
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .foregroundColor(.black)
                        .padding(.top, 8)
                    
                    
                }
                
            }.padding()
            Divider()
        }
    }
}

struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: Thread.sampleThread)
            .previewLayout(PreviewLayout.fixed(width: 300, height: 300))
    }
}


struct LikesView: View {
    
    enum LikesCount {
        case one
        case two
        case three
    }
    
    let thread: Thread
    let likesCount: LikesCount
    
    var body: some View {
        VStack(spacing: 1) {
            
            if likesCount == .one {
                CircularProfileImageView(user: thread.user, size: .xxxxSmall)
            }else if likesCount == .two {
                HStack(spacing: 1) {
                    CircularProfileImageView(user: thread.user, size: .xxxxSmall)
                    CircularProfileImageView(user: thread.user, size: .xxxxSmall)
                }
            } else {
                VStack(spacing: 1) {
                    
                    CircularProfileImageView(user: thread.user, size: .xxxxSmall)
                    HStack(spacing: 1) {
                        CircularProfileImageView(user: thread.user, size: .xxxxSmall)
                        CircularProfileImageView(user: thread.user, size: .xxxxSmall)
                        
                    }
                }
            }
        }
    }
}
