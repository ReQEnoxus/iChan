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
    var dataSource: BoardsDataSource!
    weak var view: BoardSelectorViewInput!
    var router: BoardSelectorRouter!
    
    //MARK: - View Output
    func initialSetup() {
        
        view.connectDataSource(dataSource)
        view.displayLoadingView()
        interactor.obtainBoards()
    }
    
    func refreshInErrorState() {
        
        view.displayLoadingView()
        interactor.obtainBoards()
    }
    
    func refreshRequested() {
        interactor.manualRefresh()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
        if let board = dataSource.board(for: indexPath) {
            
            router.pushToThreadSelector(board: board)
        }
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
    
    func searchRequested(query: String) {
        interactor.performSearch(by: query)
    }
    
    //MARK: - Interactor Output
    func didFinishObtainingBoards(boards: BoardCategories) {
        
        dataSource.boardCategories = boards
        view.refreshData()
        view.displayTableView()
        
    }
    
    func didFinishRefreshingBoards(boards: BoardCategories) {
        
        dataSource.boardCategories = boards
        view.refreshData()
    }
    
    func didFinishObtainingBoards(with error: ApiError) {
        view.displayErrorView(type: .network)
    }
    
    func didPerformSearch(boards: BoardCategories) {
        
        dataSource.boardCategories = boards
        
        view.refreshData()
        
        if boards.categories.isEmpty {
            
            if !view.isDisplayingSearchErrorView {
                
                view.displayErrorView(type: .search)
            }
        }
        else if view.isDisplayingSearchErrorView {
            view.displayTableView()
        }
    }
    
    //MARK: - DataSourceOutput
    func didFinishPinningItem(at index: IndexPath?, sectionCreated: Bool) {
        
        guard let index = index else { return }
        
        interactor.updateCachedCopy(with: dataSource.boardCategories)
        view.pinItem(at: index, sectionAdded: sectionCreated)
    }
    
    func didFinishUnpinningItem(at index: IndexPath?, sectionDeleted: Bool) {
        
        guard let index = index else { return }
        
        interactor.updateCachedCopy(with: dataSource.boardCategories)
        view.unpinItem(at: index, sectionDeleted: sectionDeleted)
    }
}
