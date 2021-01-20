//
//  CFIdentifiable.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

@objc public protocol CFIdentifiable: class {
    var idItem: Int { get }
    var nameItem: String { get }
}

@objc public protocol CFIdentifiableContainer: CFIdentifiable {
    var items: [CFIdentifiable] { get }
}
