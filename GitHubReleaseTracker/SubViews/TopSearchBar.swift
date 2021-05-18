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
    @State var isEditing = true
    var body: some View {
        HStack {
            Button(action: {
                isEditing = false
                hideKeyboard()
                vm.refresh()
            }, label: {
                Image("refreshIcon")
                    .resizable()
                    .frame(width:20, height:20)
                    .colorMultiply(Color(UIColor.darkGray))
            }).padding(.trailing,10)
            ZStack{
                Color.gray
                    .frame(height:36)
                    .cornerRadius(8)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.black)
                        .padding(.leading, 10)
                    TextField("Search", text: $text)
                        .autocapitalization(.none)
                        .onTapGesture {
                            isEditing = true
                        }
                }
                .frame(height:36)
                .animation(.default)
            }
            Button(action: {
                isEditing = false
                hideKeyboard()
                vm.addTrackItem(repo: text)
                text = ""
                vm.refresh()
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size:25))
            })
            
        }.foregroundColor(Color(UIColor.darkGray))
        
    }
}
