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
    @State private var selectedE: Release?
    @State private var fullScreen = false
    
    func widthForString(s: String) -> CGFloat {
        return s.widthOfString(usingFont: .systemFont(ofSize: 30, weight: .bold))
    }
    
    var versions: [Release]
    var body: some View {
        let screen = UIScreen.main.bounds
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                if(!fullScreen){
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
                    VStack(spacing:0){
                        Text(vm.getRepoKey(url: versions[0].url))
                            .bold()
                            .font(.system(size: 30))
                        Rectangle()
                            .frame(width: widthForString(s: vm.getRepoKey(url: versions[0].url)), height: 6)
                            .foregroundColor(.red)
                            .padding(.bottom, 20)
                    }
                    Spacer()
                }
                ScrollView(showsIndicators: false){
                    VStack (spacing: 20){
                        ForEach(versions, id:\.self.tagName){ e in
                            HStack{
                                Text(e.name)
                                    .onTapGesture {
                                        selectedE=e
                                    }
                                Spacer()
                                Text(e.tagName)
                            }
                            .frame(width: screen.width-50)
                        }
                    }
                }
                }
                if(selectedE != nil){
                    HStack {
                        Button(action: {
                            fullScreen.toggle()
                        }, label: {
                            if(fullScreen){
                                Image(systemName: "arrow.down")
                                    .font(.system(size:28))
                            }else{
                                Image(systemName: "arrow.up")
                                    .font(.system(size:28))
                            }
                           
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            selectedE = nil
                            fullScreen = false
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size:28))
                        })
                    }.padding(.horizontal, 22)
                    BodySheetView(e: selectedE!)
                        .transition(.move(edge: .bottom))
                        .animation(.default)
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
