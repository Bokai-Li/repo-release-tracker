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
    
    @State var showSortOptions = false
    
    @State var selectedSortOption = sortBy.nameAsc
    
    var body: some View {
        var array = Array(vm.trackItemDictionary.keys)
        array = array.filter{$0.contains(text.lowercased()) || text == ""}
        switch selectedSortOption {
        case .nameAsc:
            array.sort()
        case .nameDes:
            array.sort(by: >)
        }
        
        return ZStack {
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
                    
                    Button(action: {
                        showSortOptions = true
                    }, label: {
                        HStack {
                            Text("Sort by")
                                .font(.system(size: 18))
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(180), anchor: .center)
                            
                            Spacer()
                            
                        }
                        .padding()
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    ScrollView{
                        ForEach(array, id:\.self) { key in
                                HStack{
                                    ItemView(vm: vm, Detailkey: $Detailkey, key: key)
                                        .padding()
                                }
                            }
                    }
                    Spacer()
                }
            }
            if(showSortOptions){
                Group {
                    Color.black.opacity(0.9)
                    
                    VStack(spacing:40){
                        Spacer()
                        ForEach(sortBy.allCases, id: \.self) {
                            sortOption in
                            
                            Button(action: {
                                selectedSortOption = sortOption
                                showSortOptions = false
                            }, label: {
                                if sortOption == selectedSortOption {
                                    Text("\(sortOption.rawValue)")
                                        .bold()
                                } else {
                                    Text("\(sortOption.rawValue)")
                                        .foregroundColor(.gray)
                                }
                            })
                        }
                        Spacer()
                        Button(action:{
                            showSortOptions = false
                        }){
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size:40))
                            
                        }
                        .padding(.bottom, 30)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .font(.title2)
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
