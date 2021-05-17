//
//  ContentView.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/14/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = VM()
    
    @State private var text = ""
    
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                TopSearchBar(vm: vm, text: $text)
                
                ScrollView{
                    ForEach(Array(vm.trackItemDictionary.keys.enumerated()), id:\.element) { _, key in
                            HStack{
                                ItemView(vm: vm, key: key)
                                    .padding()
                            }
                        }
                }
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
