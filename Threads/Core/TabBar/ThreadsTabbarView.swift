//
//  ThreadsTabbarView.swift
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

struct ThreadsTabbarView: View {
    
    @State private var selectedTab = 0
    @State var isShowingNewThreadView: Bool = false
    @StateObject var viewModel = CurrentUserProfileViewModel()

//    @EnvironmentObject var user:User
    
    var body: some View {
        TabView(selection: $selectedTab){
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }.onAppear { selectedTab = 0 }.tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.onAppear { selectedTab = 1 }.tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }.onAppear { selectedTab = 2 }.tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }.onAppear { selectedTab = 3 }.tag(3)
            
           CurrentProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }.onAppear { selectedTab = 4 }.tag(4)

        }.accentColor(.black)
            .onChange(of: selectedTab, perform: { _ in
                isShowingNewThreadView = selectedTab == 2
            })
            .sheet(isPresented: $isShowingNewThreadView, onDismiss: {
                selectedTab = 0
            }, content: {
                NewThreadView(isShowingNewThreadView: $isShowingNewThreadView)
            })
    }
}

struct ThreadsTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadsTabbarView()
    }
}
