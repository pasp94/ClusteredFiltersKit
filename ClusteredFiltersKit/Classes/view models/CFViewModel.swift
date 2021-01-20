//
//  CFCollectionVM.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

@objc open class CFViewModel: NSObject {
    
    var clusters: [CFIdentifiableContainer]
    
    public var cfDelegate: CFDelegate?
    
    var filtersRefresh: (() -> ())?
    
    var selectedClusterIdx: Int
    var selectedFilterIdx: Int
    
    var firstSelection = true
    var clusterChanged = true
    
    @objc public init(items: [CFIdentifiableContainer], selectedClusterIdx: Int = 0, selectedFilterIdx: Int = 0) {
        self.clusters = items
        self.selectedClusterIdx = selectedClusterIdx
        self.selectedFilterIdx  = selectedFilterIdx
    }
}

extension CFViewModel: CFViewModelProtocol {
    
    public var numberOfClusters: Int {
        return clusters.count
    }
    
    public var numberOfFilters: Int {
        return clusters[selectedClusterIdx].items.count
    }
    
    public var indexForSelectedCluster: Int {
        return selectedClusterIdx
    }
    
    public var indexForSelectedFilter: Int {
        return selectedFilterIdx
    }
    
    public func calculeteCellWidth(collectionType: CFView.CFCollectionType, at index: Int) -> CGFloat {
        switch collectionType {
        case .clusters:
            guard index < clusters.count else { return .zero }
            return clusters[index].nameItem.size(withAttributes: nil).width + 40
            
        case .filters:
            guard index < clusters[selectedClusterIdx].items.count else { return .zero }
            return clusters[selectedClusterIdx].items[index].nameItem.size(withAttributes: nil).width + 40
            
        case .unknown:
            return .zero
        }
    }
    
    
    public func bindeFileters(completion: @escaping () -> ()) {
        self.filtersRefresh = completion
    }
    
    public func bindDataCell<CELL>(cell: CELL, at indexPath: IndexPath, for collectionType: CFView.CFCollectionType) where CELL : ConfigurableCell {
        
        switch collectionType {
        case .unknown:
            break
        case .clusters where cell is CFNamedCell:
            guard indexPath.row < clusters.count else {return}
            let item = clusters[indexPath.row]
            
            let viewModel = CFNamedCellVM(item: item)
            cell.setViewModel(viewModel)
            break
        case .filters where cell is CFNamedCell:
            guard indexPath.row < clusters[selectedClusterIdx].items.count else {return}
            let item = clusters[selectedClusterIdx].items[indexPath.row]
            
            let viewModel = CFNamedCellVM(item: item)
            cell.setViewModel(viewModel)
            break
        default:
            return
        }
        
    }
    
    public func didSelectCluster(at indexPath: IndexPath, completion: @escaping (Bool) -> ()) {
        /// implemente model protocol method to check
        /// if index is inside the range
        if !firstSelection {
            guard indexPath.row != selectedClusterIdx else { clusterChanged = false; return }
            clusterChanged = true
        }
        
        selectedClusterIdx = indexPath.row
        selectedFilterIdx = !firstSelection ? 0 : selectedFilterIdx
        
        firstSelection = false
        
        let cluster = clusters[selectedClusterIdx]
        
        completion(cluster.items.count > 1)
        
        if cluster.items.count > 0 {
            /// call delegate method with `selectedClusterIdx`
            /// and `selectedFilterIdx` as zero
            let filter = cluster.items[selectedFilterIdx]
            cfDelegate?.didSelectFilter(filter.idItem, ofCluster: cluster.idItem)
            
            filtersRefresh?()
        }
    }
    
    public func didSelectFilter(at indexPath: IndexPath) {
        /// implemente model protocol method to check
        /// if index is inside the range
        guard selectedFilterIdx != indexPath.row || clusterChanged else { return }
        clusterChanged = false
        
        selectedFilterIdx = indexPath.row
        let cluster = clusters[selectedClusterIdx]
        if cluster.items.count > 0 {
            /// call delegate method with `selectedClusterIdx`
            /// and `selectedFilterIdx` as zero
            let filter = cluster.items[selectedFilterIdx]
            cfDelegate?.didSelectFilter(filter.idItem, ofCluster: cluster.idItem)
        }
    }
}
