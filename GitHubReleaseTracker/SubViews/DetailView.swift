//
//  DetailView.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/17/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var vm: VM
    @Binding var Detailkey: String?
    
    @State private var showingSheet = false
    
    var versions: [Element]
    var body: some View {
        let screen = UIScreen.main.bounds
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack {
                    Spacer()
                    
                    Button(action: {
                        Detailkey = nil
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size:28))
                    })
                }.padding(.horizontal, 22)
                HStack{
                    Spacer()
                    Text(vm.getRepoKey(url: versions[0].url))
                        .bold()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                ScrollView(showsIndicators: false){
                    VStack (spacing: 20){
                        ForEach(versions, id:\.self.tagName){ e in
                            HStack{
                                Text(e.name)
                                Spacer()
                                Text(e.tagName)
                            }
                            .frame(width: screen.width-50)
                            .onTapGesture {
                                showingSheet.toggle()
                            }
                            .sheet(isPresented: $showingSheet) {
                                    BodySheetView(e: e)
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
