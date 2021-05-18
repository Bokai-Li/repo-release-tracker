//
//  ContentView.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/14/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = VM()
    
    @State private var text = ""
    
    @State var Detailkey: String?
    
    var body: some View {
        return
            ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            if(Detailkey != nil){
                DetailView(vm: vm, Detailkey: $Detailkey, versions: vm.getAllVersionInfo(repo: Detailkey!))
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }else{
                VStack {
                    HStack{
                        Image(systemName: "arkit")
                            .font(.system(size:40))
                        Text("Github Relase Tracker")
                            .bold()
                            .font(.title)
                    }
                    .foregroundColor(.white)
                    TopSearchBar(vm: vm, text: $text)
                        .padding(.top, 30)
                    
                    ScrollView{
                        ForEach(array, id:\.element) { _, key in
                                HStack{
                                    ItemView(vm: vm, Detailkey: $Detailkey, key: key)
                                        .padding()
                                }
                            }
                    }
                    Spacer()
                }
            }
            if(vm.err != .noError){
                Group {
                    Color.black.opacity(0.7)
                    VStack{
                        switch vm.err {
                        case .empty:
                            Text("Input cannot be empty")
                        case .noRelease:
                            Text("No release info found with the given repo")
                        case .decode:
                            Text("No info found with the given repo name")
                        default:
                            Text("Unknown Error")
                        }
                        Button(action:{
                            vm.dismissError()
                        }){
                            Text("Dismiss")
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .font(.title2)
                .zIndex(1)
            }
        }.foregroundColor(.white)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
