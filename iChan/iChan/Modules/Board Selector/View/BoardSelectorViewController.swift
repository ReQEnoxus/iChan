//
//  BoardSelectorViewController.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class BoardSelectorViewController: UIViewController, UITableViewDelegate, BoardSelectorViewInput {
    
    //MARK: - UI Constants
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
        
        static let pinActionLeftOffset: CGFloat = 15
        static let pinActionTopOffset: CGFloat = 0
        static let unpinActionLeftOffset: CGFloat = 13
        static let unpinActionTopOffset: CGFloat = 0
        static let pinActionSize = CGSize(width: 30, height: 30)
        static let unpinActionSize = CGSize(width: 30, height: 30)
        
        //MARK: - View Constants
        static let title = "Доски"
        static let pinActionTitle = "Закрепить"
        static let unpinActionTitle = "Открепить"
        static let searchPlaceholder = "Поиск доски"
        static let pinActionImage = "SF_pin_slash_fill"
        static let unpinActionImage = "SF_pin_slash"
        static let numberOfLinesInLabel = 0
        
        static let loadingAnimationName = "loading"
        static let loadingAnimationWidth = 200
        static let loadingAnimationHeight = 200
        
        static let conatinerSpacing: CGFloat = 10
        static let errorLogoImageSize = CGSize(width: 150, height: 150)
        static let errorLogoLeftShift: CGFloat = 30
        static let errorLogoImageName = "SF_exclamationmark_octagon-1"
        
        static let errorText = "Не удалось загрузить доски"
        static let searchErrorText = "Доски не найдены"
        static let retryButtonTitle = "Обновить"
    }
    
    var presenter: BoardSelectorViewOutput!
    
    var searchInProgress = false
    var isDisplayingSearchErrorView = false
    
    private var searchBarIsActive = false
        
    lazy var tableView: UITableView = {
        
        var tableView = UITableView()
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        
        let controller = UISearchController(searchResultsController: .none)
        
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = Appearance.searchPlaceholder
        controller.definesPresentationContext = true
        
        return controller
    }()
    
    lazy var loadingView: AnimationView = {
        
        var loadingView = AnimationView()
        loadingView.animation = Animation.named(Appearance.loadingAnimationName)
        loadingView.loopMode = .loop
        
        return loadingView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .orangeUi
        
        return refreshControl
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
        retryButton.addTarget(self, action: #selector(refreshInErrorState), for: .touchUpInside)
        
        containter.addArrangedSubview(imageView)
        containter.addArrangedSubview(textLabel)
        containter.addArrangedSubview(retryButton)
        
        return containter
    }()
    
    lazy var searchErrorView: UIStackView = {
        
        let containter = UIStackView()
        containter.alignment = .center
        containter.axis = .vertical
        containter.spacing = Appearance.conatinerSpacing
        
        let errorImage = UIImage(named: Appearance.errorLogoImageName)?.resizeAndShift(newSize: Appearance.errorLogoImageSize, shiftLeft: .zero, shiftTop: .zero)
        let imageView = UIImageView(image: errorImage)
        let textLabel = UILabel()
        textLabel.text = Appearance.searchErrorText
        textLabel.textColor = .white
        
        containter.addArrangedSubview(imageView)
        containter.addArrangedSubview(textLabel)
        
        return containter
    }()
    
    var initialLoad = true
    
    let favouriteHeaderTitle = "Избранное"
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if initialLoad {
            
            configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: Appearance.title, preferredLargeTitle: true)
            fixLargeTitlePositioning()
            initialLoad = false
        }
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .blackBg
        
        tableView.estimatedRowHeight = Appearance.cellHeight
        
        presenter.initialSetup()
        
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = UIRectEdge.top
        
        setupTableView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    @objc func refreshInErrorState() {
        presenter.refreshInErrorState()
    }
    
    func setupTableView() {
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        tableView.register(cell: BoardTableViewCell.self)
        tableView.indicatorStyle = .white
        tableView.contentInsetAdjustmentBehavior = .always
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
        
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        
        if !searchBarIsActive {
            
            presenter.refreshRequested()
        }
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
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
            
            favAction.image = UIImage(named: Appearance.pinActionImage)?.resizeAndShift(newSize: Appearance.pinActionSize, shiftLeft: Appearance.pinActionLeftOffset, shiftTop: Appearance.pinActionTopOffset)
        }
        else {
            
            favAction.image = UIImage(named: Appearance.unpinActionImage)?.resizeAndShift(newSize: Appearance.unpinActionSize, shiftLeft: Appearance.unpinActionLeftOffset, shiftTop: Appearance.unpinActionTopOffset)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [favAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    //MARK: - BoardSelectorViewInput
    func connectDataSource(_ dataSource: BoardsDataSource) {
        tableView.dataSource = dataSource
    }
    
    func refreshData() {
        
        refreshControl.endRefreshing()
        tableView.reloadData()
        searchInProgress = false
    }
    
    func pinItem(at index: IndexPath, sectionAdded: Bool) {
        
        tableView.beginUpdates()
        
        if sectionAdded {
            tableView.insertSections(IndexSet([0]), with: .automatic)
        }
        
        tableView.insertRows(at: [index], with: .automatic)
        
        tableView.endUpdates()
    }
    
    func unpinItem(at index: IndexPath, sectionDeleted: Bool) {
        
        tableView.beginUpdates()
        
        if sectionDeleted {
            tableView.deleteSections(IndexSet([0]), with: .automatic)
        }
        
        tableView.deleteRows(at: [index], with: .automatic)
        
        tableView.endUpdates()
    }
    
    func displayTableView() {
        
        isDisplayingSearchErrorView = false
        
        if navigationItem.searchController == .none {
            navigationItem.searchController = searchController
        }
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    
    func displayErrorView(type: ErrorType) {
        
        let viewToDisplay: UIView
        
        switch type {
        case .network:
            viewToDisplay = errorView
        case .search:
            isDisplayingSearchErrorView = true
            viewToDisplay = searchErrorView
        }
        
        refreshControl.endRefreshing()
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(viewToDisplay)
        view.backgroundColor = .blackBg
        
        viewToDisplay.snp.makeConstraints { make in
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
    
    //MARK: - Utils
    private func fixLargeTitlePositioning() {
        
        let top = tableView.adjustedContentInset.top
        let y = refreshControl.frame.maxY + top
        tableView.setContentOffset(CGPoint(x: .zero, y: -y), animated: true)
    }
}

extension BoardSelectorViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if !searchBarIsActive {
            searchBarIsActive = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBarIsActive = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text, !searchInProgress else { return }
        
        searchInProgress.toggle()
        presenter.searchRequested(query: query)
    }
}
