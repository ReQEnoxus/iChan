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
        
        static let saveLeftShift: CGFloat = 13
        static let saveTopShift: CGFloat = -3
        static let actionImageSize = CGSize(width: 40, height: 40)
        
        static let collapseActionTitle = "  Скрыть  "
        static let saveActionTitle = "Сохранить"
        
        static let collapseImageName = "SF_eye_fill"
        static let saveImageName = "SF_square_and_arrow_down_on_square"
    }
    
    let scrollDelta: CGFloat = 10
    var isLoading: Bool = false
    
    var presenter: ThreadSelectorViewOutput!
    let tableView: UITableView = UITableView()
    
    lazy var refreshControl: UIRefreshControl = {
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .orangeUi
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.tintColor = .orangeUi
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as! ThreadTableViewCell
        
        if !cell.isCollapsed {
            
            let collapseAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                
                self?.presenter.didPressedCollapse(on: indexPath)
                
                completion(true)
            }
            
            collapseAction.backgroundColor = .swipeActionPrimary
            collapseAction.image = UIImage(named: Appearance.collapseImageName)?.resizeAndShift(newSize: Appearance.actionImageSize, shiftLeft: .zero, shiftTop: .zero)
            
            let saveAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                // todo: implement save action
                completion(true)
            }
            
            saveAction.backgroundColor = .swipeActionSecondary
            saveAction.image = UIImage(named: Appearance.saveImageName)?.resizeAndShift(newSize: Appearance.actionImageSize, shiftLeft: Appearance.saveLeftShift, shiftTop: Appearance.saveTopShift)
            
            let configuration = UISwipeActionsConfiguration(actions: [saveAction, collapseAction])
            
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
        }
        else {
            return nil
        }
    }
    
    func setupTableView() {
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        
        tableView.register(cell: ThreadTableViewCell.self)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= scrollDelta, !isLoading {
            
            isLoading = true
            presenter.loadMoreThreads()
        }
    }
    
    @objc func refresh() {
        presenter.refreshRequested()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ThreadTableViewCell
        
        presenter.didSelectItem(at: indexPath, collapsed: cell.isCollapsed)
    }
    
    
    //MARK: - ThreadSelectorViewInput
    
    func setBoardName(_ name: String) {
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: name, preferredLargeTitle: true)
    }
    
    func refreshData() {
        
        refreshControl.endRefreshing()
        tableView.reloadData()
        
        isLoading = false
    }
    
    func connectDataSource(_ dataSource: ThreadSelectorDataSource) {
        tableView.dataSource = dataSource
    }
    
    func collapseCell(at indexpath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexpath) as! ThreadTableViewCell
        tableView.beginUpdates()
        cell.collapse()
        tableView.layoutIfNeeded()
        tableView.endUpdates()
    }
    
    func expandCell(at indexpath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexpath) as! ThreadTableViewCell
        tableView.beginUpdates()
        cell.expand()
        tableView.layoutIfNeeded()
        tableView.endUpdates()
    }
}
