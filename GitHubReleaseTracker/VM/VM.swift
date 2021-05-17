//
//  VM.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/14/21.
//

import Foundation
import SwiftUI

class VM: ObservableObject {
    @Published var results = [Element]()
    
    @Published var trackItemList = [String]()
    
    @Published var trackItemDictionary: [String: (e: Element, new: Bool)] = [:]
    
    public func addTrackItem(repo: String) {
        trackItemList.append(repo)
    }
    
    public func refresh() {
        for repo in trackItemList {
            loadData(repo: repo)
        }
    }
    
    public func getRepoKey(url: String) -> String {
        let pattern = "repos/[a-zA-Z]+/[a-zA-Z]+/releases"
        let range = url.range(of: pattern, options:.regularExpression)

        if let range = range {
            let l = url.index(range.lowerBound, offsetBy: 6)
            let r = url.index(range.upperBound, offsetBy: -9)
            let repoRange = l..<r
            return String(url[repoRange])
        }
        return ""
    }
    
    public func loadData(repo:String) {
        guard let url = URL(string:"https://api.github.com/repos/\(repo)/releases") else {
            print("invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do{
                //print(String(data: data, encoding: .utf8)!)
                let res = try JSONDecoder().decode(Welcome.self, from: data)
                    DispatchQueue.main.async {
                        let key = self.getRepoKey(url: res[0].url)
                        let element = res[0]
                        if(self.trackItemDictionary[key]==nil){
                            self.trackItemDictionary[key] = (element, true)
                        } else if(self.trackItemDictionary[self.getRepoKey(url: res[0].url)]!.e.tagName != element.tagName){
                            self.trackItemDictionary[self.getRepoKey(url: res[0].url)] = (element, true)
                        } else {
                            self.trackItemDictionary[self.getRepoKey(url: res[0].url)] = (element, false)
                        }
                    }
                    return
            }
            catch{
                print(error)
            }
            
        }.resume()
    }
}
