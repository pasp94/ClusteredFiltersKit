//
//  CFNamedCellVM.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

final class CFNamedCellVM {
    
    private let cfGenericItem: CFIdentifiable
    
    init(item: CFIdentifiable) {
        self.cfGenericItem = item
    }
}

extension CFNamedCellVM: NamedCellViewModelProtocol {
    var name: String {
        return cfGenericItem.nameItem
    }
}
