//
//  CFCollectionVM.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

open class CFViewModel {
    
    var clusters: [CFIdentifiableContainer]
    
    var selectedClusterIdx = 0
    var selectedFilterIdx = 0
    
    public init(items: [CFIdentifiableContainer]) {
        self.clusters = items
    }
}

extension CFViewModel: CFViewModelProtocol {
    
    public var numberOfClusters: Int {
        return clusters.count
    }
    
    public var numberOfFilters: Int {
        return clusters[selectedClusterIdx].items.count
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
        selectedClusterIdx = indexPath.row
        completion(clusters[selectedClusterIdx].items.count > 1)
        
        if clusters[selectedClusterIdx].items.count > 0 {
            /// call delegate method with `selectedClusterIdx`
            /// and `selectedFilterIdx` as zero
        }
    }
    
    public func didSelectFilter(at indexPath: IndexPath) {
        /// implemente model protocol method to check
        /// if index is inside the range
        selectedFilterIdx = indexPath.row
        //
    }
}
