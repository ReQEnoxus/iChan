//
//  ThreadViewController.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class ThreadViewController: UIViewController, ThreadViewInput, UITableViewDelegate {
    
    //MARK: - UI Constraints
    private class Appearance {
        
        //MARK: - Constraints
        static let tableViewOffsetTop = 0
        static let tableViewOffsetBottom = 0
        static let tableViewOffsetLeft = 0
        static let tableViewOffsetRight = 0
        
        static let footerHeight: CGFloat = 60
        static let defaultCellHeight: CGFloat = 44
        
        static let conatinerSpacing: CGFloat = 10
        
        static let errorLogoImageSize = CGSize(width: 150, height: 150)
        static let errorLogoLeftShift: CGFloat = 30
        
        static let errorText = "Не удалось загрузить тред"
        static let retryButtonTitle = "Обновить"
        
        static let errorLogoImageName = "SF_exclamationmark_octagon-1"
        
        static let loadingAnimationName = "loading"
        static let loadingAnimationWidth = 200
        static let loadingAnimationHeight = 200
    }
    
    var presenter: ThreadViewOutput!
    
    private var cellHeightCache = [IndexPath: CGFloat]()
    
    //MARK: - Views
    lazy var tableView: UITableView = {
        
        var tableView = UITableView()
        tableView.allowsSelection = false
        tableView.refreshControl = refreshControl
        tableView.indicatorStyle = .white
        
        return tableView
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
    
    lazy var indicatorView: UIActivityIndicatorView = {
        
        var view = UIActivityIndicatorView()
        view.color = .orangeUi
        view.startAnimating()
        view.hidesWhenStopped = true
        
        return view
    }()
    
    lazy var footerFrame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: Appearance.footerHeight)
    
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
    
    var previousScrollViewBottomInset: CGFloat = .zero
    
    var initialLoad = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .blackBg
        setupTableView()
        presenter.initialSetup()
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: String(), preferredLargeTitle: true)
        navigationItem.largeTitleDisplayMode = .never
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if initialLoad {
            
            presenter.loadThread()
            initialLoad = false
        }
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightCache[indexPath] ?? Appearance.defaultCellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightCache[indexPath] = cell.bounds.height
    }
    
    //MARK: - PullUpToRefresh
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let contentSize = scrollView.contentSize.height
        let tableSize = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        let canLoadFromBottom = contentSize > tableSize

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let difference = maximumOffset - currentOffset

        if canLoadFromBottom, difference <= -Appearance.footerHeight {
            
            indicatorView.startAnimating()
            indicatorView.frame = footerFrame
            tableView.tableFooterView = indicatorView
            tableView.tableFooterView?.isHidden = false
            
            previousScrollViewBottomInset = scrollView.contentInset.bottom

            scrollView.contentInset.bottom = previousScrollViewBottomInset + Appearance.footerHeight

            presenter.update()
        }
        
        scrollView.contentInset.bottom = previousScrollViewBottomInset
    }
    
    private func stopLoading() {
        
        indicatorView.stopAnimating()
        tableView.tableFooterView?.isHidden = true
        tableView.tableFooterView = nil
        tableView.contentInset.bottom = previousScrollViewBottomInset
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    //MARK: - objc refresh methods
    @objc func refresh() {
        presenter.update()
    }
    
    @objc func refreshInErrorState() {
        presenter.refreshInErrorState()
    }
    
    //MARK: - Setup methods
    func setupTableView() {
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        
        tableView.register(cell: ThreadPostCell.self)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
        
        tableView.contentInset.bottom = tabBarController?.tabBar.frame.height ?? .zero
    }
    
    //MARK: - Thread View Input
    func refreshData() {
        tableView.reloadData()
    }
    
    func refreshData(indicesToInsert: [IndexPath], indicesToUpdate: [IndexPath], animated: Bool) {
        
        if !animated {
            
            UIView.performWithoutAnimation {
                
                tableView.beginUpdates()
                tableView.insertRows(at: indicesToInsert, with: .automatic)
                tableView.endUpdates()
                
                tableView.beginUpdates()
                tableView.reloadRows(at: indicesToUpdate, with: .automatic)
                tableView.endUpdates()
                stopLoading()
            }
        }
        else {
            
            tableView.beginUpdates()
            tableView.insertRows(at: indicesToInsert, with: .automatic)
            tableView.endUpdates()
            
            tableView.beginUpdates()
            tableView.reloadRows(at: indicesToUpdate, with: .automatic)
            tableView.endUpdates()
            stopLoading()
        }
    }
    
    func connectDataSource(_ dataSource: ThreadDataSource) {
        tableView.dataSource = dataSource
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
}
