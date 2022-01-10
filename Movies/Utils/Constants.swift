//
//  Constants.swift
//
//
//  
//

import Foundation
import UIKit

public enum Category{
    case popular
    case top_rated
    case upcoming
    case latest
}

enum Environment{
    case Developer
    case Production
}

class Constants{
    static let environment: Environment = .Developer
    
    static var urlMobile: URL{
        switch self.environment{
        case .Developer:
            return URL(string: "")!
        default:
            return URL(string: "")!
        }
    }
    
    static var urlBase: URL {
        switch self.environment {
        case .Developer:
            return URL(string: "")!
        default:
            return URL(string: "")!
        }
    }
    
    struct Keys {
        static var client_secret = environment == .Developer
                                    ? ""
                                    : ""
        
        static var client_id = environment == .Developer
                                    ? ""
                                    : ""
    }
    
    
    struct Font {
        static let nBlack =  UIFont(name: "Nunito-Black", size: UIFont.systemFontSize)!
        static let nBlackItalic =  UIFont(name: "Nunito-BlackItalic", size: UIFont.systemFontSize)!
        static let nBold =  UIFont(name: "Nunito-Bold", size: UIFont.systemFontSize)!
        static let nBoldItalic =  UIFont(name: "Nunito-BoldItalic", size: UIFont.systemFontSize)!
        static let nExtraBold =  UIFont(name: "Nunito-ExtraBold", size: UIFont.systemFontSize)!
        static let nExtraBoldItalic =  UIFont(name: "Nunito-ExtraBoldItalic", size: UIFont.systemFontSize)!
        static let nExtraLight =  UIFont(name: "Nunito-ExtraLight", size: UIFont.systemFontSize)!
        static let nExtraLightItalic =  UIFont(name: "Nunito-ExtraLightItalic", size: UIFont.systemFontSize)!
        static let nItalic =  UIFont(name: "Nunito-Italic", size: UIFont.systemFontSize)!
        static let nLight =  UIFont(name: "Nunito-Light", size: UIFont.systemFontSize)!
        static let nLightItalic =  UIFont(name: "Nunito-LightItalic", size: UIFont.systemFontSize)!
        static let nRegular =  UIFont(name: "Nunito-Regular", size: UIFont.systemFontSize)!
        static let nSemiBold =  UIFont(name: "Nunito-SemiBold", size: UIFont.systemFontSize)!
        static let nSemiBoldItalic =  UIFont(name: "Nunito-SemiBoldItalic", size: UIFont.systemFontSize)!
    }
    
    struct Color {
        @available(iOS 11.0, *)
        static let black = UIColor(named: "black")!
        @available(iOS 11.0, *)
        static let white = UIColor(named: "white")!
        @available(iOS 11.0, *)
        static let blue = UIColor(named: "blue")!
        @available(iOS 11.0, *)
        static let blue_short = UIColor(named: "blue_short")!
        @available(iOS 11.0, *)
        static let gray = UIColor(named: "gray")!
    }
    
    struct Urls {
        static let regularImageBaseURLString: String = "https://image.tmdb.org/t/p/w185"
        static let backdropImageBaseURLString: String = "https://image.tmdb.org/t/p/w500"
        static let themoviedbBaseURLString: String = "https://www.themoviedb.org"
        static let youtubeImgBaseURLString: String = "https://img.youtube.com"
        static let youtubeBaseURLString: String = "https://www.youtube.com"
    }

}

typealias fonts = Constants.Font
typealias colors = Constants.Color
typealias keys = Constants.Keys
typealias urls = Constants.Urls
