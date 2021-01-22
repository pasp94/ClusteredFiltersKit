//
//  UIColor+Complementary.swift
//  ClusteredFiltersKit
//
//  Created by Pasquale Spisto on 21/01/2021.
//

import Foundation


extension UIColor {
    
    public var complementary: UIColor {
        get {
            let ciColor = CIColor(color: self)
            
            let compRed: CGFloat    = 1.0 - ciColor.red
            let compGreen: CGFloat  = 1.0 - ciColor.green
            let compBlue: CGFloat   = 1.0 - ciColor.blue
            
            return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        }
    }
    
    public var isLight: Bool {
        let rgbColor = CIColor(color: self)
        let darknessScore: CGFloat = (((rgbColor.red * 255) * 299) + ((rgbColor.green * 255) * 587) + ((rgbColor.blue * 255) * 114)) / 1000
        
        return darknessScore >= 125.0
    }
}
