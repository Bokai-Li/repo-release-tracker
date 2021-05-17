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
    
    @State var Detailkey: String?
    
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            if(Detailkey != nil){
                DetailView(vm: vm, Detailkey: $Detailkey, versions: vm.getAllVersionInfo(repo: Detailkey!))
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }else{
                VStack {
                    
                    TopSearchBar(vm: vm, text: $text)
                        .padding(.top, 30)
                    
                    ScrollView{
                        ForEach(Array(vm.trackItemDictionary.keys.enumerated()), id:\.element) { _, key in
                                HStack{
                                    ItemView(vm: vm, Detailkey: $Detailkey, key: key)
                                        .padding()
                                }
                            }
                    }
                    Spacer()
                }
            }
        }.foregroundColor(.white)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
