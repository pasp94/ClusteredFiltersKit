//
//  ConfigurableCell.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

import UIKit

/// All the cells the can be configured with ViewModels
/// that conform to the defined protocols: `NamedCellVMProtocol`
public protocol ConfigurableCell {
   /// Allow to a genercs cell to be configured with one of the following ViewModelCell Protocols
   ///   - Parameters
   ///      - `viewModels`: the object in charge of matching the data of cells with them UI
    func setViewModel<ViewModelType: NamedCellViewModelProtocol>(_ viewModel: ViewModelType, cellStyle: CFCellStyle)
}
