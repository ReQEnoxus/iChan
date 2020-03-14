//
//  BoardSecectorPresenter.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardSelectorPresenter: BoardSelectorViewOutput, BoardSelectorInteractorOutput, BoardsDataSourceOutput {
    
    var interactor: BoardSelectorInteractorInput!
    var dataSource: BoardsDataSourceProtocol!
    weak var view: BoardSelectorViewInput!
    var router: BoardSelectorRouter!
    
    //MARK: - View Output
    func initialSetup() {
        
        view.connectDataSource(dataSource)
        interactor.obtainBoards()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        // TODO: Navigate to BoardView
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        
        return dataSource.titleForHeaderInSection(section: section)
    }
    
    func pinItem(at: IndexPath) {
        
        dataSource.pinItem(at: at)
    }
    
    func unpinItem(at: IndexPath) {
        
        dataSource.unpinItem(at: at)
    }
    
    //MARK: - Interactor Output
    func didFinishObtainingBoards(boards: BoardCategories) {
        
        dataSource.boardCategories = boards
        view.refreshData()
    }
    
    //MARK: - DataSourceOutput
    func didFinishPinningItem(at index: IndexPath?, sectionCreated: Bool) {
        
        guard let index = index else { return }
        
        view.pinItem(at: index, sectionAdded: sectionCreated)
    }
    
    func didFinishUnpinningItem(at index: IndexPath?, sectionDeleted: Bool) {
        
        guard let index = index else { return }
        
        view.unpinItem(at: index, sectionDeleted: sectionDeleted)
    }
}
