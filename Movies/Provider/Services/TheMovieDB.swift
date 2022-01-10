//
//  TheMovieDB.swift
//  Movies
//
//  Created by Yair Saucedo on 20/11/21.
//

import Foundation

class TheMovieDB {
    
    private var url:String
    private var apiKey:String

    init (){
        let baseConfiguration: BaseConfiguration = PropertyListHelper.decode()
        url = baseConfiguration.keys.url
        apiKey = baseConfiguration.keys.apiKey
    }
    
    var refreshData = { () -> () in }
    
    //Fuente de datos
    var dataArray: [ShowTheMovie] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retriveData(lastPage:Int, category:Category, completion: @escaping (_ result: Error?) -> Void) {
        let url = URL(string: "\(url)/movie/\(category)?api_key=\(apiKey)&language=en-US&page=\(lastPage)")

        //YSH 6 Ene
        let tarea:URLSessionDataTask = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                if (data == nil) {
                    completion(Network.errorDomainCFNetwork)
                }
                guard let json = data else { return }
                
                let responseString = NSString(data: json, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")

                let decoder = JSONDecoder()
                let result:Result = try decoder.decode(Result.self, from: json)
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
