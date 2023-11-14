//
//  Font+Extension.swift
//  WeatherCombineExample
//
//  Created by ParkJunHyuk on 2023/11/14.
//

import UIKit

enum AppFontName: String {
    case regular = "SFProDisplay-Regular"
    case medium = "SFProDisplay-Medium"
    case bold = "SFProDisplay-Bold"
    case light = "SFProDisplay-Light"
    case thin = "SFProDisplay-Thin"
    case semibold = "SFProDisplay-Semibold"
    
    var name: String {
        return self.rawValue
    }
}

extension UIFont {

    class func regular(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: size)!
    }

    class func medium(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: size)!
    }

    class func bold(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold.rawValue, size: size)!
    }
    
    class func light(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light.rawValue, size: size)!
    }
    
    class func thin(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.thin.rawValue, size: size)!
    }
    
    class func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semibold.rawValue, size: size)!
    }
}
