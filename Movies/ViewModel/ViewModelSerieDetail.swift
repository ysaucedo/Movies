//
//  ViewModelSerieDetail.swift
//  Movies
//
//  Created by Yair Saucedo on 21/11/21.
//

import UIKit
import Foundation

class ViewModelSerieDetail {
    
    //Mecanismo enlazar la vista con este modelo de la vista
    var refreshData = { () -> () in }
    
    //Fuente de datos
    var dataArray: [Video] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retriveData(id:Int32, completion: @escaping (_ result: Error?) -> Void) {
        let themoviews = VideoDB()
        themoviews.retriveSerieData(id: id, completion: {
            (respuesta) in
            if (respuesta != nil) {
                print(respuesta!.localizedDescription)
                completion(respuesta)
            }
        })
        themoviews.refreshData = { [weak self] () in
            self!.dataArray = themoviews.dataArray
        }

    }
    
}
