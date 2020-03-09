//
//  BoardSelectorViewController.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class BoardSelectorViewController: UIViewController, UITableViewDelegate, BoardSelectorViewInput {
    
    private class Appearance {
        
        //MARK: - Constraints
        static let tableViewOffsetTop = 0
        static let tableViewOffsetBottom = 0
        static let tableViewOffsetLeft = 0
        static let tableViewOffsetRight = 0
        
        static let cellHeight: CGFloat = 66
        static let headerHeight: CGFloat = 38
        
        static let headerLabelOffsetTop = 14
        static let headerLabelOffsetBottom = -6
        static let headerLabelOffsetLeft = 16
        static let headerLabelOffsetRight = 16
        
        //MARK: - View Constants
        static let title = "Доски"
        static let pinActionTitle = "Закрепить"
        static let unpinActionTitle = "Открепить"
        static let pinActionImage = "pin"
        static let unpinActionImage = "pin.slash"
        static let numberOfLinesInLabel = 0
    }
    
    var presenter: BoardSelectorViewOutput!
        
    let tableView: UITableView = UITableView()
    
    let favouriteHeaderTitle = "Избранное"
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: Appearance.title, preferredLargeTitle: true)
        tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.nibName)
        
        tableView.estimatedRowHeight = Appearance.cellHeight
        
        presenter.initialSetup()
    }
    
    override func loadView() {
        
        super.loadView()
        setupTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    func setupTableView() {
        
        tableView.backgroundColor = UIColor.blackBg
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .blackBg
        
        let label = UILabel()
        label.textColor = .headerTitleColor
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            
            make.left.equalTo(view).offset(Appearance.headerLabelOffsetLeft)
            make.right.equalTo(view).offset(Appearance.headerLabelOffsetRight)
            make.bottom.equalTo(view).offset(Appearance.headerLabelOffsetBottom)
            make.top.equalTo(view).offset(Appearance.headerLabelOffsetTop)
        }
        
        label.text = presenter.titleForHeaderInSection(section: section)?.uppercased()
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Appearance.headerHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let pinning = presenter.titleForHeaderInSection(section: indexPath.section) != favouriteHeaderTitle
        
        let favAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            
            if pinning {
                self?.presenter.pinItem(at: indexPath)
            }
            else {
                self?.presenter.unpinItem(at: indexPath)
            }
            
            completion(true)
        }
        
        favAction.backgroundColor = .swipeActionPrimary
        
        if pinning {
            
            favAction.title = Appearance.pinActionTitle
            favAction.image = UIImage(systemName: Appearance.pinActionImage)
        }
        else {
            
            favAction.title = Appearance.unpinActionTitle
            favAction.image = UIImage(systemName: Appearance.unpinActionImage)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [favAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    //MARK: - BoardSelectorViewInput
    func connectDataSource(_ dataSource: BoardsDataSourceProtocol) {
        tableView.dataSource = dataSource
    }
    
    func refreshData() {
        tableView.reloadData()
    }
}

