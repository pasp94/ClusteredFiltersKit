//
//  ModelsExample.swift
//  ClusteredFiltersKit_Example
//
//  Created by Pasquale Spisto on 13/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ClusteredFiltersKit

class Filter {
    var name: String = ""
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

extension Filter: CFIdentifiable {
    var idItem: Int {
        return self.id
    }
    
    var nameItem: String {
        return self.name
    }
}

extension Filter {
    public static func getFakefilters() -> [Filter] {
        return [
            Filter(name: "Filter 1w", id: 1),
            Filter(name: "Filter 2ww", id: 2),
            Filter(name: "Filter 3www", id: 3),
            Filter(name: "Filter 4wwww", id: 4),
            Filter(name: "Filter 5wwwww", id: 5),
            Filter(name: "Filter 6wwwwww", id: 6)
        ]
    }
}


class Cluster {
    var name: String
    var id: Int
    var filters: [Filter]
    
    init(name: String, id: Int, filters: [Filter]) {
        self.name = name
        self.id = id
        self.filters = filters
    }
}

extension Cluster: CFIdentifiableContainer {
    var items: [CFIdentifiable] {
        return filters
    }
    
    var idItem: Int {
        return id
    }
    
    var nameItem: String {
        return name
    }
}

extension Cluster {
    public static func getFakeClusters() -> [Cluster] {
        return [
            Cluster(name: "Cluster 1w", id: 1, filters: Filter.getFakefilters()),
            Cluster(name: "Cluster 2ww", id: 2, filters: [Filter(name: "One filter", id: 10001)]),
            Cluster(name: "Cluster 3www", id: 3, filters: Filter.getFakefilters()),
            Cluster(name: "Cluster 4wwww", id: 4, filters: [Filter(name: "One filter", id: 10001), Filter(name: "One filter", id: 10002)]),
            Cluster(name: "Cluster 5wwwww", id: 5, filters: [Filter(name: "One filter", id: 10002)]),
            Cluster(name: "Cluster 6wwwwww", id: 6, filters: Filter.getFakefilters())
        ]
    }
}
