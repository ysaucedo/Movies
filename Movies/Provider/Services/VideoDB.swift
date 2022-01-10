//
//  VideoDB.swift
//  Movies
//
//  Created by Yair Saucedo on 21/11/21.
//

import Foundation

class VideoDB {
    
    private var url:String
    private var apiKey:String

    init (){
        let baseConfiguration: BaseConfiguration = PropertyListHelper.decode()
        url = baseConfiguration.keys.url
        apiKey = baseConfiguration.keys.apiKey
    }
    
    var refreshData = { () -> () in }
    
    //Fuente de datos
    var dataArray: [Video] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retriveData(id: Int32, completion: @escaping (_ result: Error?) -> Void) {
        let url = URL(string: "\(url)/movie/\(id)/videos?api_key=\(apiKey)&language=en-US")
            
        let tarea:URLSessionDataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if (data == nil) {
                    completion(Network.errorDomainCFNetwork)
                }
                guard let json = data else { return }
                
                let responseString = NSString(data: json, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")

                let decoder = JSONDecoder()
                let result:ResultVideo = try decoder.decode(ResultVideo.self, from: json)
                //self.dataArray = try decoder.decode([ShowTheMovie].self, from: json)
                self.dataArray = result.results
            } catch let error {
                print(String(describing: error))
                //print("error  \(error.localizedDescription) ")
            }
        }
        tarea.resume()
    }
    
    func retriveSerieData(id: Int32, completion: @escaping (_ result: Error?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)/videos?api_key=356016d8da514101815ff58c16ef4639&language=en-US")
            
        let tarea:URLSessionDataTask = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            do {
                if (data == nil) {
                    completion(Network.errorDomainCFNetwork)
                }
                guard let json = data else { return }
                
                let responseString = NSString(data: json, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")

                let decoder = JSONDecoder()
                let result:ResultVideo = try decoder.decode(ResultVideo.self, from: json)
                //self.dataArray = try decoder.decode([ShowTheMovie].self, from: json)
                self!.dataArray = result.results
            } catch let error {
                print(String(describing: error))
                //print("error  \(error.localizedDescription) ")
            }
        }
        tarea.resume()
    }
    
}

enum Network: Error {
    case errorDomainCFNetwork
}
