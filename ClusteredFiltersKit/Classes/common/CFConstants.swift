//
//  CFConstants.swift
//  ClusteredFiltersKit
//
//  Created by Pasquale Spisto on 13/01/2021.
//

import Foundation

struct CFConstants {
    
    static var runningMode: RunningMode { .debugUI }
    static var collectionsSpacing: CGFloat { 5.0 }
    static var collectionsSideInset: CGFloat { 20.0 }
    static var animationShortTime: TimeInterval { 0.35 }
    static var animationMediumTime: TimeInterval { 0.5 }
    
}


extension CFConstants {
    
    enum RunningMode: Int {
        case debug      = 0
        case debugUI
        case normal
    }
}

