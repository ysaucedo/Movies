//
//  ViewModelCatalog.swift
//  Movies
//
//  Created by Yair Saucedo on 07/01/22.
//

import UIKit
import Foundation

class ViewModelCatalog {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //Mecanismo enlazar la vista con este modelo de la vista
    var refreshData = { () -> () in }
    var refreshDataRecommendations = { () -> () in }
    var refreshDataRated = { () -> () in }

    var refreshDataSerie = { () -> () in }
    var refreshDataSerieRecommendations = { () -> () in }
    var refreshDataSerieRated = { () -> () in }
    
    var lastPage:Int = 0
    var lastPageRecommendations:Int = 0
    var lastPageRated:Int = 0

    var lastPageSerie:Int = 0
    var lastPageSerieRecommendations:Int = 0
    var lastPageSerieRated:Int = 0
    
    //Fuente de datos
    var dataArray: [Show] = [] {
        didSet {
            refreshData()
        }
    }

    var dataArrayRecommendations: [Show] = [] {
        didSet {
            refreshDataRecommendations()
        }
    }

    var dataArrayRated: [Show] = [] {
        didSet {
            refreshDataRated()
        }
    }
    
    var dataArraySerie: [Serie] = [] {
        didSet {
            refreshDataSerie()
        }
    }
    
    var dataArraySerieRecommendations: [Serie] = [] {
        didSet {
            refreshDataSerieRecommendations()
        }
    }

    var dataArraySerieRated: [Serie] = [] {
        didSet {
            refreshDataSerieRated()
        }
    }
    
    func retriveData(category:Category, completion: @escaping (_ result: Error?) -> Void) {
                
        do{
            var page:Int
            switch category {
            case .popular:
                lastPage+=1
                page = lastPage
                self.dataArray = try self.context.fetch(Show.fetchRequest(category: category))
            case .top_rated:
                lastPageRated+=1
                page = lastPageRated
                self.dataArrayRated = try self.context.fetch(Show.fetchRequest(category: category))
            case .upcoming:
                lastPageRecommendations+=1
                page = lastPageRecommendations
                self.dataArrayRecommendations = try self.context.fetch(Show.fetchRequest(category: category))
            case .latest:
                lastPageRecommendations+=1
                page = lastPageRecommendations
                self.dataArrayRecommendations = try self.context.fetch(Show.fetchRequest(category: category))
            }

            let themoviews = TheMovieDB()
            themoviews.retriveData(lastPage: page, category: category, completion: {
                (respuesta) in
                if (respuesta != nil) {
                    print(respuesta!.localizedDescription)
                    completion(respuesta)
                }
            })
            themoviews.refreshData = { [weak self] () in
                do{

                    for showTheMovie in themoviews.dataArray {
                        //Revisar si ya se encuentra la película en la base de datos
                        let show: Show! = try self?.context.fetch(Show.fetchRequestById(id: showTheMovie.id, category: category)).first

                        if (show == nil){
                            let newItem = Show(context: self!.context)
                            newItem.adult = false
                            //newItem.genre_ids
                            newItem.backdrop_path = showTheMovie.backdrop_path
                            newItem.id = showTheMovie.id
                            newItem.original_language = showTheMovie.original_language
                            newItem.overview = showTheMovie.overview
                            newItem.popularity = showTheMovie.popularity
                            newItem.poster_path = showTheMovie.poster_path
                            newItem.release_date = showTheMovie.release_date
                            newItem.title = showTheMovie.title
                            newItem.video = showTheMovie.video
                            newItem.vote_average = showTheMovie.vote_average
                            newItem.vote_count = showTheMovie.vote_count
                            newItem.category = "\(category)"
                            try self!.context.save()
                        }
                        
                    }
                    
                    switch category {
                    case .popular:
                        self!.dataArray = try self!.context.fetch(Show.fetchRequest(category: category))
                    case .top_rated:
                        self!.dataArrayRated = try self!.context.fetch(Show.fetchRequest(category: category))
                    case .upcoming:
                        self!.dataArrayRecommendations = try self!.context.fetch(Show.fetchRequest(category: category))
                    case .latest:
                        self!.dataArrayRecommendations = try self!.context.fetch(Show.fetchRequest(category: category))
                    }
                    
                } catch {
                    print("error  \(error.localizedDescription) ")
                }
            }
                
            
        } catch {
            print("error  \(error.localizedDescription) ")
        }
    }

    func retriveDataSerie(category:Category, completion: @escaping (_ result: Error?) -> Void) {
                
        do{
            var page:Int
            switch category {
            case .popular:
                lastPageSerie+=1
                page = lastPageSerie
                self.dataArraySerie = try self.context.fetch(Serie.fetchRequest(category: category))
            case .top_rated:
                lastPageSerieRated+=1
                page = lastPageSerieRated
                self.dataArraySerieRated = try self.context.fetch(Serie.fetchRequest(category: category))
            case .upcoming:
                lastPageSerieRecommendations+=1
                page = lastPageSerieRecommendations
                self.dataArraySerieRecommendations = try self.context.fetch(Serie.fetchRequest(category: category))
            case .latest:
                lastPageSerieRecommendations+=1
                page = lastPageSerieRecommendations
                self.dataArraySerieRecommendations = try self.context.fetch(Serie.fetchRequest(category: category))
            }

            let themoviews = SerieDB()
            themoviews.retriveData(lastPage: page, category: category, completion: {
                (respuesta) in
                if (respuesta != nil) {
                    print(respuesta!.localizedDescription)
                    completion(respuesta)
                }
            })
            themoviews.refreshData = { [weak self] () in
                do{

                    for showTheMovie in themoviews.dataArray {
                        //Revisar si ya se encuentra la serie en la base de datos
                        let show: Show! = try self?.context.fetch(Show.fetchRequestById(id: showTheMovie.id, category: category)).first

                        if (show == nil){
                            let newItem = Serie(context: self!.context)
                            newItem.backdrop_path = showTheMovie.backdrop_path
                            newItem.category = "\(category)"
                            newItem.first_air_date = showTheMovie.first_air_date
                            newItem.id = showTheMovie.id
                            newItem.name = showTheMovie.name
                            newItem.original_language = showTheMovie.original_language
                            newItem.overview = showTheMovie.overview
                            newItem.popularity = showTheMovie.popularity
                            newItem.poster_path = showTheMovie.poster_path
                            newItem.vote_average = showTheMovie.vote_average
                            newItem.vote_count = showTheMovie.vote_count
                            try self!.context.save()
                        }
                        
                    }
                    
                    switch category {
                    case .popular:
                        self!.dataArraySerie = try self!.context.fetch(Serie.fetchRequest(category: category))
                    case .top_rated:
                        self!.dataArraySerieRated = try self!.context.fetch(Serie.fetchRequest(category: category))
                    case .upcoming:
                        self!.dataArraySerieRecommendations = try self!.context.fetch(Serie.fetchRequest(category: category))
                    case .latest:
                        self!.dataArraySerieRecommendations = try self!.context.fetch(Serie.fetchRequest(category: category))
                    }
                    
                } catch {
                    print("error  \(error.localizedDescription) ")
                }
            }
                
            
        } catch {
            print("error  \(error.localizedDescription) ")
        }
    }
    
    
}
