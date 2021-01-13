//
//  CFCollectionVM.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

final class CFViewModel {
    
    var clusters: [CFIdentifiableContainer]
    
    var selectedClusterIdx = 0
    var selectedFilterIdx = 0
    
    init(items: [CFIdentifiableContainer]) {
        self.clusters = items
    }
}

extension CFViewModel: CFViewModelProtocol {
    
    var numberOfClusters: Int {
        return clusters.count
    }
    
    var numberOfFilters: Int {
        return clusters[selectedClusterIdx].items.count
    }
    
    func identifiableNameWidth(at indexPath: IndexPath) -> Float {
        return Float(clusters[indexPath.row].nameItem.size(withAttributes: nil).width) + 40
    }
    
    func bindDataCell<CELL>(cell: CELL, at indexPath: IndexPath, for collectionType: CFView.CFCollectionType) where CELL : ConfigurableCell {
        
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
    
    func didSelectCluster(at indexPath: IndexPath) {
        selectedClusterIdx = indexPath.row
        
        //
    }
    
    func didSelectFilter(at indexPath: IndexPath) {
        selectedFilterIdx = indexPath.row
        //
    }
}
