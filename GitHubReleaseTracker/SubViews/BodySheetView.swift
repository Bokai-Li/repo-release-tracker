//
//  DetailSheetView.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/17/21.
//

import SwiftUI

struct BodySheetView: View {
    var e: Release
    func widthForString(s: String) -> CGFloat {
        return s.widthOfString(usingFont: .systemFont(ofSize: 30, weight: .bold))
    }
    var body: some View {
        ZStack{
            Color(UIColor.darkGray)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(spacing:0){
                    Text(e.name)
                        .font(.title)
                        .frame(height:80)
                        .padding()
                }
                HStack{
                    Spacer()
                    Text(e.tagName)
                    Spacer()
                    Text(e.publishedAt)
                    Spacer()
                }
                RoundedRectangle(cornerRadius:10)
                    .fill(Color(.systemGray5))
                    .frame(width:350, height:1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding()
                ScrollView{
                    Text(e.body)
                        .padding()
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct BodySheetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("2021-05-11, Version 14.17.0 'Fermium' (LTS), @danielleadams")
                    .font(.title)
                    .frame(height:100)
                    .padding()
                Text("2021-05-11T23:39:47Z")
                Text("v14.17.0")
                RoundedRectangle(cornerRadius:10)
                    .fill(Color(.systemGray5))
                    .frame(width:350, height:1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding()
                ScrollView{
                    Text("### Notable Changes\r\n\r\n#### Diagnostics channel (experimental module)\r\n\r\n`diagnostics_channel` is a  [preload scripts (James M Snell) [#37481](https://github.com/nodejs/node/pull/37481)")
                }
            }
        }
        .foregroundColor(.white)
    }
}
