//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Yair Saucedo on 21/11/21.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    func testCanGetDataMovies() throws {
    
        let expectation = XCTestExpectation(description: "Download Movies")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=356016d8da514101815ff58c16ef4639&language=en-US&page=1")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
            
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }

    func testCanParseDataMovies() throws {
    
        let expectation = XCTestExpectation(description: "Parse Movies")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=356016d8da514101815ff58c16ef4639&language=en-US&page=1")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let json = data else { return }
            let decoder = JSONDecoder()
            guard let dataArray = try? decoder.decode(Result.self, from: json) else { return }
            
            XCTAssertNotNil(dataArray, "No data was conveerted.")

            expectation.fulfill()
            
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testCanGetDataSeries() throws {
    
        let expectation = XCTestExpectation(description: "Download Movies")
        
        let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=356016d8da514101815ff58c16ef4639&language=en-US&page=1")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
            
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }

    func testCanParseDataSeries() throws {
    
        let expectation = XCTestExpectation(description: "Parse Movies")
        
        let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=356016d8da514101815ff58c16ef4639&language=en-US&page=1")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let json = data else { return }
            let decoder = JSONDecoder()
            guard let dataArray = try? decoder.decode(ResultSerie.self, from: json) else { return }
            
            XCTAssertNotNil(dataArray, "No data was conveerted.")

            expectation.fulfill()
            
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testCanGetDataVideos() throws {
    
        let expectation = XCTestExpectation(description: "Download Movies")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/50410/videos?api_key=356016d8da514101815ff58c16ef4639&language=en-US")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
            
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }

    func testCanParseDataVideos() throws {
    
        let expectation = XCTestExpectation(description: "Parse Movies")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/50410/videos?api_key=356016d8da514101815ff58c16ef4639&language=en-US")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let json = data else { return }
            let decoder = JSONDecoder()
            guard let dataArray = try? decoder.decode(ResultVideo.self, from: json) else { return }
            
            XCTAssertNotNil(dataArray, "No data was conveerted.")

            expectation.fulfill()
            
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10.0)
        
    }
    

}
