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
import JGProgressHUD

class ThreadSelectorViewController: UIViewController, ThreadSelectorViewInput, UITableViewDelegate, JGProgressHUDDelegate {
    
    //MARK: - UI Constraints
    private class Appearance {
        
        //MARK: - Constraints
        static let tableViewOffsetTop = 0
        static let tableViewOffsetBottom = 0
        static let tableViewOffsetLeft = 0
        static let tableViewOffsetRight = 0
        
        static let conatinerSpacing: CGFloat = 10
        
        static let saveLeftShift: CGFloat = 13
        static let saveTopShift: CGFloat = -3
        static let actionImageSize = CGSize(width: 40, height: 40)
        static let errorLogoImageSize = CGSize(width: 150, height: 150)
        static let errorLogoLeftShift: CGFloat = 30
        static let errorViewWidthMultiplier = 0.75
        static let errorLabelLineNumber = 0
        
        static let collapseActionTitle = "  Скрыть  "
        static let saveActionTitle = "Сохранить"
        static let networkErrorText = "Не удалось загрузить треды с этой доски"
        static let cacheErrorText = "Здесь будут отображаться просмотренные треды"
        static let historyErrorText = "Здесь будут отображаться сохраненные треды"
        static let retryButtonTitle = "Обновить"
        
        static let collapseImageName = "SF_eye_fill"
        static let saveImageName = "SF_square_and_arrow_down_on_square"
        static let networkErrorLogoImageName = "SF_exclamationmark_octagon-1"
        static let cacheErrorLogoImageName = "SF_clock_fill-1"
        static let historyErrorLogoImageName = "SF_square_and_arrow_down_on_square-1"
        static let historyDeleteActionImageName = "SF_xmark_octagon"
        
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
    
    var isVisible: Bool {
        
        return self.viewIfLoaded?.window != nil
    }
    
    var isInitialRefresh = true
    
    var historyContextualSetup = false
    
    var presenter: ThreadSelectorViewOutput!
    let tableView: UITableView = UITableView()
    var boardName: String!
    
    //MARK: - Views
    
    lazy var hud: JGProgressHUD = {
        
        let hud = JGProgressHUD(style: .dark)
        hud.interactionType = .blockAllTouches
        hud.indicatorView = HudAnimationView()
        hud.delegate = self
        
        return hud
    }()
    
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
    
    lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = Appearance.errorLabelLineNumber
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var retryButton: UIButton = {
        
        let retryButton = UIButton(type: .system)
        
        retryButton.setTitle(Appearance.retryButtonTitle, for: .normal)
        retryButton.tintColor = .orangeUi
        retryButton.setTitleColor(.orangeUi, for: .normal)
        retryButton.setTitleColor(.orangeUiDarker, for: .selected)
        retryButton.addTarget(self, action: #selector(refreshInErrorState), for: .touchUpInside)
        
        return retryButton
    }()
    
    lazy var errorImageView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var errorView: UIStackView = {
        
        let containter = UIStackView()
        containter.alignment = .center
        containter.axis = .vertical
        containter.spacing = Appearance.conatinerSpacing
        
        containter.addArrangedSubview(errorImageView)
        containter.addArrangedSubview(errorLabel)
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
        extendedLayoutIncludesOpaqueBars = true
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
        
        if !historyContextualSetup {
        
            if !cell.isCollapsed {
                
                let collapseAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                    
                    self?.presenter.didPressedCollapse(on: indexPath)
                    
                    completion(true)
                }
                
                collapseAction.backgroundColor = .swipeActionPrimary
                collapseAction.image = UIImage(named: Appearance.collapseImageName)?.resizeAndShift(newSize: Appearance.actionImageSize, shiftLeft: .zero, shiftTop: .zero)
                
                let saveAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                    
                    self?.presenter.didPressedSave(on: indexPath)
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
        else {
            
            let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                
                self?.presenter.didPressedDelete(on: indexPath)
                completion(true)
            }
            
            deleteAction.backgroundColor = .swipeActionPrimary
            deleteAction.image = UIImage(named: Appearance.historyDeleteActionImageName)?.resizeAndShift(newSize: Appearance.actionImageSize, shiftLeft: .zero, shiftTop: .zero)
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            
            configuration.performsFirstActionWithFullSwipe = true
            
            return configuration
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
    
    @objc func refreshInErrorState() {
        presenter.refreshInErrorState()
    }
    
    //MARK: - ThreadSelectorViewInput
    func setBoardName(_ name: String) {
        boardName = name
    }
    
    func configureHistoryContextualActions() {
        historyContextualSetup = true
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
    
    func displayErrorView(style: ErrorMessageStyle) {
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        switch style {
            
        case .network:
            
            errorLabel.text = Appearance.networkErrorText
            errorImageView.image = UIImage(named: Appearance.networkErrorLogoImageName)?.resizeAndShift(newSize: Appearance.errorLogoImageSize, shiftLeft: Appearance.errorLogoLeftShift, shiftTop: .zero)
            retryButton.isHidden = false
            
        case .cache:
            
            errorLabel.text = Appearance.cacheErrorText
            errorImageView.image = UIImage(named: Appearance.cacheErrorLogoImageName)?.resizeAndShift(newSize: Appearance.errorLogoImageSize, shiftLeft: .zero, shiftTop: .zero)
            retryButton.isHidden = true
            
        case .history:
            
            errorLabel.text = Appearance.historyErrorText
            errorImageView.image = UIImage(named: Appearance.historyErrorLogoImageName)?.resizeAndShift(newSize: Appearance.errorLogoImageSize, shiftLeft: .zero, shiftTop: .zero)
            retryButton.isHidden = true
        }
        
        view.addSubview(errorView)
        view.backgroundColor = .blackBg
        
        errorView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(Appearance.errorViewWidthMultiplier)
        }
    }
    
    func displayLoadingHud() {
        
        loadingView.play()
        hud.show(in: view, animated: true)
    }
    
    func hideLoadingHud() {
        
        loadingView.stop()
        hud.dismiss(animated: true)
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
    
    func disablePullToRefresh() {
        tableView.refreshControl = nil
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
    
    func refreshData(indicesToRefresh: [IndexPath]) {
        
        refreshControl.endRefreshing()
        tableView.insertRows(at: indicesToRefresh, with: .automatic)
        
        isLoading = false
    }
    
    func refreshData(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath]) {
        
        tableView.beginUpdates()
        
        tableView.deleteRows(at: deletions, with: .automatic)
        tableView.insertRows(at: insertions, with: .automatic)
        tableView.reloadRows(at: modifications, with: .automatic)
        
        tableView.endUpdates()
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
    
    //MARK: - JGProgressHUDDelegate
    func progressHUD(_ progressHUD: JGProgressHUD, willPresentIn view: UIView) {
        
        if let indicatorView = progressHUD.indicatorView as? HudAnimationView {
            
            indicatorView.playAnimation()
        }
    }
    
    func progressHUD(_ progressHUD: JGProgressHUD, didDismissFrom view: UIView) {
        
        if let indicatorView = progressHUD.indicatorView as? HudAnimationView {
            
            indicatorView.stopAnimation()
        }
    }
    
    //MARK: - Utils
    private func fixLargeTitlePositioning() {
        
        let top = tableView.adjustedContentInset.top
        let y = refreshControl.frame.maxY + top
        tableView.setContentOffset(CGPoint(x: .zero, y: -y), animated:true)
    }
}
