//
//  SettingsViewController.swift
//  iChan
//
//  Created by Enoxus on 11.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewInput {
    
    private class Appearance {
        
        static let cellHeight: CGFloat = 55
        
        static let settingsTitle = "Настройки"
    }
    
    var presenter: SettingsViewOutput!
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.register(cell: UITableViewCell.self)
        
        tableView.backgroundColor = .blackBg
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        return tableView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    //MARK: - Setup
    func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - View Input
    func registerDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func configureNavBar() {
        configureNavigationBar(largeTitleColor: .white, backgroundColor: .darkNavBar, tintColor: .white, title: Appearance.settingsTitle, preferredLargeTitle: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Appearance.cellHeight
    }
}
