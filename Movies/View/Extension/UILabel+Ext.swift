//
//  UILabel+Ext.swift
//  
//
//

import Foundation
import UIKit

@available(iOS 11.0, *)
extension UILabel {
    
    func stylLbl(_ text: String, _ font: UIFont? = fonts.nRegular, _ color: UIColor? = colors.black, _ size: CGFloat? = 15){
        self.text = text
        self.textColor = color ?? colors.black
        self.font = (font ?? fonts.nRegular).withSize(size ?? 15)
        self.backgroundColor = .clear
    }
    
    
    func twoColors(_ text: (String, String), _ font: (UIFont, UIFont), _ color: (UIColor, UIColor), _ size: (CGFloat, CGFloat)) {
        
        let attrs1 = [NSAttributedString.Key.font : font.0.withSize(size.0), NSAttributedString.Key.foregroundColor : color.0]
        let attrs2 = [NSAttributedString.Key.font : font.1.withSize(size.1), NSAttributedString.Key.foregroundColor : color.1]
        
        let attributedString1 = NSMutableAttributedString(string: text.0, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: text.1, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.attributedText = attributedString1
    }
    
    func fourColors(_ text: (String, String, String, String), _ font: (UIFont, UIFont, UIFont, UIFont),
                    _ color: (UIColor, UIColor, UIColor, UIColor), _ size: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        
        let attrs1 = [NSAttributedString.Key.font : font.0.withSize(size.0), NSAttributedString.Key.foregroundColor : color.0]
        let attrs2 = [NSAttributedString.Key.font : font.1.withSize(size.1), NSAttributedString.Key.foregroundColor : color.1]
        let attrs3 = [NSAttributedString.Key.font : font.2.withSize(size.2), NSAttributedString.Key.foregroundColor : color.2]
        let attrs4 = [NSAttributedString.Key.font : font.3.withSize(size.3), NSAttributedString.Key.foregroundColor : color.3]
        
        let attributedString1 = NSMutableAttributedString(string: text.0, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: text.1, attributes:attrs2)
        
        let attributedString3 = NSMutableAttributedString(string: text.2, attributes:attrs3)
        
        let attributedString4 = NSMutableAttributedString(string: text.3, attributes:attrs4)
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        
        self.attributedText = attributedString1
    }
    
    func notification(){
        self.backgroundColor = colors.blue
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
