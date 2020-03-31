//
//  ThreadSelectorViewController.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class ThreadSelectorViewController: UIViewController, ThreadSelectorViewInput, UITableViewDelegate {
    
    //MARK: - UI Constraints
    private class Appearance {
        
        //MARK: - Constraints
        static let tableViewOffsetTop = 0
        static let tableViewOffsetBottom = -80
        static let tableViewOffsetLeft = 0
        static let tableViewOffsetRight = 0
        
        static let conatinerSpacing: CGFloat = 10
        
        static let saveLeftShift: CGFloat = 13
        static let saveTopShift: CGFloat = -3
        static let actionImageSize = CGSize(width: 40, height: 40)
        static let errorLogoImageSize = CGSize(width: 150, height: 150)
        static let errorLogoLeftShift: CGFloat = 30
        
        static let collapseActionTitle = "  Скрыть  "
        static let saveActionTitle = "Сохранить"
        static let errorText = "Не удалось загрузить треды с этой доски"
        static let retryButtonTitle = "Обновить"
        
        static let collapseImageName = "SF_eye_fill"
        static let saveImageName = "SF_square_and_arrow_down_on_square"
        static let errorLogoImageName = "SF_exclamationmark_octagon-1"
        
        static let defaultCellHeight: CGFloat = 44
        
        static let footerHeight: CGFloat = 60
        static let collapsedFooterHeright: CGFloat = 10
        
        static let loadingAnimationName = "loading"
        static let loadingAnimationWidth = 200
        static let loadingAnimationHeight = 200
    }
    
    private var cellHeightCache = [IndexPath: CGFloat]()
        
    var isLoading: Bool = false {
        
        didSet {
            
            if isLoading {
                indicatorView.startAnimating()
            }
            else {
                indicatorView.stopAnimating()
            }
        }
    }
    var isInitialRefresh = true
    
    var presenter: ThreadSelectorViewOutput!
    let tableView: UITableView = UITableView()
    var boardName: String!
    
    //MARK: - Views
    lazy var refreshControl: UIRefreshControl = {
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .orangeUi
        
        return refreshControl
    }()
    
    lazy var loadingView: AnimationView = {
        
        var loadingView = AnimationView()
        loadingView.animation = Animation.named(Appearance.loadingAnimationName)
        loadingView.loopMode = .loop
        
        return loadingView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        
        var view = UIActivityIndicatorView()
        view.color = .orangeUi
        view.startAnimating()
        view.hidesWhenStopped = true
        
        return view
    }()
    
    lazy var errorView: UIStackView = {
        
        let containter = UIStackView()
        containter.alignment = .center
        containter.axis = .vertical
        containter.spacing = Appearance.conatinerSpacing
        
        let errorImage = UIImage(named: Appearance.errorLogoImageName)?.resizeAndShift(newSize: Appearance.errorLogoImageSize, shiftLeft: .zero, shiftTop: .zero)
        let imageView = UIImageView(image: errorImage)
        let textLabel = UILabel()
        textLabel.text = Appearance.errorText
        textLabel.textColor = .white
        
        let retryButton = UIButton(type: .system)
        retryButton.setTitle(Appearance.retryButtonTitle, for: .normal)
        retryButton.tintColor = .orangeUi
        retryButton.setTitleColor(.orangeUi, for: .normal)
        retryButton.setTitleColor(.orangeUiDarker, for: .selected)
        retryButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        
        containter.addArrangedSubview(imageView)
        containter.addArrangedSubview(textLabel)
        containter.addArrangedSubview(retryButton)
        
        return containter
    }()
    
    lazy var footerFrame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: Appearance.footerHeight)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .blackBg
        navigationItem.backBarButtonItem?.tintColor = .orangeUi
        tableView.indicatorStyle = .white
        presenter.initialSetup()
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: boardName, preferredLargeTitle: true)
        presenter.refreshRequested()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func loadView() {
        
        super.loadView()
        setupTableView()
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightCache[indexPath] ?? Appearance.defaultCellHeight   
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cellHeightCache[indexPath] = cell.bounds.height
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex, !isLoading {
            
            indicatorView.startAnimating()
            indicatorView.frame = footerFrame
            
            tableView.tableFooterView = indicatorView
            tableView.tableFooterView?.isHidden = false
            
            presenter.loadMoreThreads()
            isLoading = true
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ThreadTableViewCell
        
        presenter.didSelectItem(at: indexPath, collapsed: cell.isCollapsed)
    }
    
    //MARK: - Setup methods
    func setupTableView() {
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        
        tableView.register(cell: ThreadTableViewCell.self)
        tableView.refreshControl = refreshControl
        tableView.contentInsetAdjustmentBehavior = .always
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    
    @objc func refresh() {
        presenter.refreshRequested()
    }
    
    //MARK: - ThreadSelectorViewInput
    func setBoardName(_ name: String) {
        boardName = name
    }
    
    func displayTableView() {
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    
    func displayErrorView() {
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(errorView)
        view.backgroundColor = .blackBg
        
        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func displayLoadingView() {
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(loadingView)
        
        loadingView.play()
        
        loadingView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.width.equalTo(Appearance.loadingAnimationWidth)
            make.height.equalTo(Appearance.loadingAnimationHeight)
        }
    }
    
    func stopLoadingIndicator() {
        
        indicatorView.stopAnimating()
    }
    
    func refreshData() {
        
        refreshControl.endRefreshing()
        
        if !isInitialRefresh {
            fixLargeTitlePositioning()
        }
        
        tableView.reloadData()
        
        isLoading = false
        isInitialRefresh = false
    }
    
    private func fixLargeTitlePositioning() {
        
        let top = tableView.adjustedContentInset.top
        let y = refreshControl.frame.maxY + top
        tableView.setContentOffset(CGPoint(x: .zero, y: -y), animated:true)
    }
    
    func refreshData(indicesToRefresh: [IndexPath]) {
        
        refreshControl.endRefreshing()
        tableView.insertRows(at: indicesToRefresh, with: .automatic)
        
        isLoading = false
    }
    
    func connectDataSource(_ dataSource: ThreadSelectorDataSource) {
        
        tableView.dataSource = dataSource
    }
    
    func collapseCell(at indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ThreadTableViewCell
        tableView.beginUpdates()
        cell.collapse()
        tableView.layoutIfNeeded()
        tableView.endUpdates()
    }
    
    func expandCell(at indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ThreadTableViewCell
        tableView.beginUpdates()
        cell.expand()
        tableView.layoutIfNeeded()
        tableView.endUpdates()
    }
}
