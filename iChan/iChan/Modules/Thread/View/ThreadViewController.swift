//
//  ThreadViewController.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ThreadViewController: UIViewController, ThreadViewInput, UITableViewDelegate {
    
    //MARK: - UI Constraints
    private class Appearance {
        
        //MARK: - Constraints
        static let tableViewOffsetTop = 0
        static let tableViewOffsetBottom = 0
        static let tableViewOffsetLeft = 0
        static let tableViewOffsetRight = 0
        
        static let conatinerSpacing: CGFloat = 10
        
        static let errorLogoImageSize = CGSize(width: 150, height: 150)
        static let errorLogoLeftShift: CGFloat = 30
        
        static let errorText = "Не удалось загрузить тред"
        static let retryButtonTitle = "Обновить"
        
        static let errorLogoImageName = "SF_exclamationmark_octagon-1"
    }
    
    var presenter: ThreadViewOutput!
    
    lazy var tableView: UITableView = {
        
        var tableView = UITableView()
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTableView()
        presenter.initialSetup()
        presenter.loadThread()
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: String(), preferredLargeTitle: true)
        navigationItem.largeTitleDisplayMode = .never
    }
    
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
//        retryButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        
        containter.addArrangedSubview(imageView)
        containter.addArrangedSubview(textLabel)
        containter.addArrangedSubview(retryButton)
        
        return containter
    }()
    
    //MARK: - Setup methods
    func setupTableView() {
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        
        tableView.register(cell: ThreadPostCell.self)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(view).offset(Appearance.tableViewOffsetTop)
            make.bottom.equalTo(view).offset(Appearance.tableViewOffsetBottom)
            make.left.equalTo(view).offset(Appearance.tableViewOffsetLeft)
            make.right.equalTo(view).offset(Appearance.tableViewOffsetRight)
        }
    }
    
    //MARK: - Thread View Input
    func refreshData() {
        tableView.reloadData()
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
}
