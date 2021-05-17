//
//  ItemView.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/16/21.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var vm: VM
    var key: Dictionary<String, (e: Element, new: Bool)>.Keys.Element
    var body: some View {
        let screen = UIScreen.main.bounds
        ZStack{
            if(self.vm.trackItemDictionary[key] != nil){
                if(self.vm.trackItemDictionary[key]!.new){
                    RoundedRectangle(cornerRadius:15)
                        .foregroundColor(Color(UIColor.darkGray))
                        .frame(width: screen.width-50, height: 70)
                        .shadow(color: .green, radius: 5, x: 1, y: 1)
                    HStack{
                        Text("\(key)")
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Text("\(self.vm.trackItemDictionary[key]!.e.tagName)")
                            .foregroundColor(.green)
                        
                        Spacer()
                        
                        Button(action: {
                            vm.dismiss(repo: key)
                        }, label: {
                            Image(systemName: "checkmark")
                        })
                        Button(action: {
                            vm.delete(repo: key)
                        }, label: {
                            Image(systemName: "xmark")
                        })
                        .padding(.trailing, 20)
                    }
                    .frame(width: screen.width-50, height: 70)
                } else {
                    RoundedRectangle(cornerRadius:15)
                        .foregroundColor(Color(UIColor.darkGray))
                        .frame(width: screen.width-50, height: 70)
                        .shadow(color: .white, radius: 5, x: 1, y: 1)
                    Spacer()
                    HStack{
                        Text("\(key)")
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Text("\(self.vm.trackItemDictionary[key]!.e.tagName)")
                        
                        Spacer()
                        
                        Button(action: {
                            vm.delete(repo: key)
                        }, label: {
                            Image(systemName: "xmark")
                        }).padding(.trailing, 20)
                    }
                    .frame(width: screen.width-50, height: 70)
                }
            }
        }
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let screen = UIScreen.main.bounds
        ZStack
        {
            RoundedRectangle(cornerRadius:15)
                .foregroundColor(Color(UIColor.darkGray))
                .frame(width: screen.width-50, height: 70)
                .shadow(color: .white, radius: 5, x: 1, y: 1)
            Spacer()
            HStack{
                Text("microsoft/vscode")
                    .padding(.leading, 20)
                
                Spacer()
                
                Text("1.1.1")
                
                Spacer()
                
                Button(action: {
                }, label: {
                    Image(systemName: "checkmark")
                })
                Button(action: {
                }, label: {
                    Image(systemName: "xmark")
                })
                .padding(.trailing, 20)
            }
        }
        .frame(width: screen.width-50, height: 70)
        .foregroundColor(.white)
    }
}
