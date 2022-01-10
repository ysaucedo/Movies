//
//  UIViewcontroller+Ext.swift
//  Movies Yair
//
//  Created by Yair Saucedo on 20/11/21.
//

import Foundation
import UIKit

extension UIViewController {

    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    
    
    func styleNVC(_ title: String) -> Void{
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        //self.navigationController?.navigationBar.tintColor = colors.blue
        
        //let navBarFont = fonts.nBold.withSize(30)
        /*
        let navBarAttributesDictionary: [NSObject: AnyObject]? = [NSAttributedString.Key.foregroundColor as NSObject: colors.blue, NSAttributedString.Key.font as NSObject: navBarFont]
        self.navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary as? [NSAttributedString.Key : Any]
    
        self.navigationController?.navigationBar.topItem?.title =  title
        */
    }
    
    func logoNAV(){
      
        //Redimenzionar la imagen de forma proporcional
        /*
        let image = #imageLiteral(resourceName: "LogoHorizontal").resized(toWidth: 200)

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
          imageView.contentMode = .scaleAspectFit
          imageView.image = image
       
          navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        */
    }
    
    func navBtn(_ image: UIImage, _ act: Selector) -> UIBarButtonItem{
        //var img = image
        let button = UIButton()
        button.addTarget(self, action: act, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        //img = image.resizeImage(25, opaque: false)
        //button.setImage(img, for: .normal)
        
        //button.imageView!.clipsToBounds = true
        button.imageView!.contentMode = .scaleAspectFill
        //button.imageView!.layer.cornerRadius = 12
        
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
}


enum AppStoryboard: String {
    case main = "Main"
}
