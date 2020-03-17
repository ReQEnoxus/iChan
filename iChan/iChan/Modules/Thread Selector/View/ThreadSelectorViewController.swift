//
//  ThreadSelectorViewController.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ThreadSelectorViewController: UIViewController, ThreadSelectorViewInput, UITableViewDelegate {
    
    private class Appearance {
        
        //MARK: - Constraints
        static let tableViewOffsetTop = 0
        static let tableViewOffsetBottom = 0
        static let tableViewOffsetLeft = 0
        static let tableViewOffsetRight = 0
    }
    
    var presenter: ThreadSelectorViewOutput!
    let tableView: UITableView = UITableView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.initialSetup()
        presenter.loadMoreThreads()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func loadView() {
        
        super.loadView()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        
        tableView.register(cell: ThreadTableViewCell.self)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    

    //MARK: - ThreadSelectorViewInput
    
    func setBoardName(_ name: String) {
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: name, preferredLargeTitle: true)
    }
    
    func refreshData() {
        tableView.reloadData()
    }
    
    func connectDataSource(_ dataSource: ThreadSelectorDataSource) {
        tableView.dataSource = dataSource
    }
}
