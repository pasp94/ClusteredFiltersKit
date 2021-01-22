//
//  CFCellStyle.swift
//  ClusteredFiltersKit
//
//  Created by Pasquale Spisto on 21/01/2021.
//

import Foundation

public enum CFCellStyle {
    case `default`
    case custom(_ textColor: UIColor, _ selectionColor: UIColor)
}


extension CFCellStyle {
    var normalTextColor: UIColor {
        switch self {
        case .default:
            return .darkText
        
        case .custom(let textColor, _):
            return textColor
        }
    }
    
    var selectedTextColor: UIColor {
        switch self {
        case .default:
            return .white
        
        case .custom( _, let selectionColor):
            return selectionColor.isLight ? .darkText : .white
        }
    }
    
    var selectionColor: UIColor {
        switch self {
        case .default:
            return .systemBlue
        
        case .custom(_, let selectionColor):
            return selectionColor
        }
    }
}
