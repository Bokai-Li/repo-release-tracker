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
            if(self.vm.trackItemDictionary[key]!.new){
                RoundedRectangle(cornerRadius:15)
                    .foregroundColor(Color(UIColor.darkGray))
                    .frame(width: screen.width-50, height: 70)
                    .shadow(color: .green, radius: 5, x: 1, y: 1)
                HStack{
                    Text("\(key)")
                    Text("\(self.vm.trackItemDictionary[key]!.e.tagName)")
                        .foregroundColor(.green)
                }
            } else {
                RoundedRectangle(cornerRadius:15)
                    .foregroundColor(Color(UIColor.darkGray))
                    .frame(width: screen.width-50, height: 70)
                    .shadow(color: .white, radius: 5, x: 1, y: 1)
                HStack{
                    Text("\(key)")
                    Text("\(self.vm.trackItemDictionary[key]!.e.tagName)")
                }
            }
        }
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            ItemView(vm: VM(), key: "idk")
        }
        .foregroundColor(.white)
    }
}
