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
    var textColor: UIColor {
        switch self {
        case .default:
            return .darkText
        
        case .custom(let textColor, _):
            return textColor
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
