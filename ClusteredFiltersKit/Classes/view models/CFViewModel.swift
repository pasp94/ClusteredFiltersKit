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
            guard 1..<clusters[selectedClusterIdx].items.count ~= index else { return .zero }
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
            guard 1..<clusters[selectedClusterIdx].items.count ~= indexPath.row else {return}
            let item = clusters[selectedClusterIdx].items[indexPath.row]
            
            let viewModel = CFNamedCellVM(item: item)
            cell.setViewModel(viewModel)
            break
        default:
            return
        }
        
    }
    
    public func didSelectCluster(at indexPath: IndexPath) {
        selectedClusterIdx = indexPath.row
        
        //
    }
    
    public func didSelectFilter(at indexPath: IndexPath) {
        selectedFilterIdx = indexPath.row
        //
    }
}
