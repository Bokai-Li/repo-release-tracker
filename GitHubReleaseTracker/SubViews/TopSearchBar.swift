//
//  TopSearchBar.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/16/21.
//

import SwiftUI

struct TopSearchBar: View {
    @ObservedObject var vm: VM
    @Binding var text: String
    var body: some View {
        HStack {
            Button(action: {
                vm.refresh()
            }, label: {
                Image("refreshIcon")
                    .resizable()
                    .frame(width:20, height:20)
            }).padding(.trailing,10)
            ZStack{
                Color.gray
                    .frame(width: 300, height:36)
                    .cornerRadius(8)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.black)
                        .padding(.leading, 10)
                    TextField("Search", text: $text)
                }
                .frame(width: 300, height:36)
            }
            Button(action: {
                vm.addTrackItem(repo: text)
                text = ""
                vm.refresh()
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size:25))
            })
        }
    }
}
