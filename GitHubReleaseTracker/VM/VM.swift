//
//  VM.swift
//  GitHubReleaseTracker
//
//  Created by Bokai Li on 5/14/21.
//

import Foundation
import SwiftUI

class VM: ObservableObject {
    
    @Published var err = Error.noError
    
    @Published var results = [Release]()
    
    @Published var trackItemList = [String]()
    
    @Published var trackItemDictionary: [String: (e: [Release], new: Bool)] = [:]
    
    public func dismissError() {
        err = Error.noError
    }
    
    public func addTrackItem(repo: String) {
        var repoKey = ""
        if(repo.contains("github.com")){
            repoKey = getRepoKeyGithub(url: repo)
        } else {
            repoKey = repo
        }
        if(repoKey != ""){
            trackItemList.append(repoKey)
        }else{
            self.err = .empty
        }
    }
    
    public func refresh() {
        for repo in trackItemList {
            loadData(repo: repo)
        }
    }
    
    public func dismiss(repo: String)
    {
        self.trackItemDictionary[repo]?.new = false
    }
    
    public func delete(repo: String) {
        if let index = trackItemList.firstIndex(of: repo) {
            trackItemList.remove(at: index)
            trackItemDictionary.removeValue(forKey: repo)
        }
    }
    
    public func getRepoKeyGithub(url: String) -> String {
        let pattern = "github.com/[a-zA-Z]+/[a-zA-Z]+"
        let range = url.range(of: pattern, options:.regularExpression)

        if let range = range {
            let l = url.index(range.lowerBound, offsetBy: 11)
            let repoRange = l..<range.upperBound
            return String(url[repoRange])
        }
        return ""
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
                        if(res.count<=0){
                            self.err = .noRelease
                        }else{
                            let key = self.getRepoKey(url: res[0].url)
                            let element = res
                            if(self.trackItemDictionary[key]==nil){
                                self.trackItemDictionary[key] = (element, true)
                            } else if(self.trackItemDictionary[self.getRepoKey(url: res[0].url)]!.e[0].tagName != element[0].tagName){
                                self.trackItemDictionary[self.getRepoKey(url: res[0].url)] = (element, true)
                            }
                        }
                    }
                    return
            }
            catch{
                DispatchQueue.main.async {
                    self.err = .decode
                    self.delete(repo: repo)
                }
                print(error)
            }
            
        }.resume()
    }
}


enum Error {
    case noError
    case empty
    case decode
    case noRelease
}
