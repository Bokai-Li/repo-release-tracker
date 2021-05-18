//
//  DetailSheetView.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/17/21.
//

import SwiftUI

struct BodySheetView: View {
    var e: Release
    var body: some View {
        ZStack{
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text(e.name)
                    .font(.title)
                    .frame(height:100)
                    .padding()
                Text(e.publishedAt)
                Text(e.tagName)
                RoundedRectangle(cornerRadius:10)
                    .fill(Color(.systemGray5))
                    .frame(width:350, height:1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding()
                ScrollView{
                    Text(e.body)
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
