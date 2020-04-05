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
        static let retryButtonTitle = "Обновить"
    }
    
    var presenter: BoardSelectorViewOutput!
        
    let tableView: UITableView = UITableView()
    
    lazy var loadingView: AnimationView = {
        
        var loadingView = AnimationView()
        loadingView.animation = Animation.named(Appearance.loadingAnimationName)
        loadingView.loopMode = .loop
        
        return loadingView
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
    
    let favouriteHeaderTitle = "Избранное"
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: Appearance.title, preferredLargeTitle: true)
        tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.nibName)
        tableView.indicatorStyle = .white
        extendedLayoutIncludesOpaqueBars = true
        
        tableView.estimatedRowHeight = Appearance.cellHeight
        
        presenter.initialSetup()
    }
    
    override func loadView() {
        
        super.loadView()
        view.backgroundColor = .blackBg
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
        tableView.reloadData()
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

