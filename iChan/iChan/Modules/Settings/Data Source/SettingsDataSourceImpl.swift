//
//  SettingsDataSourceImpl.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SettingsDataSourceImpl: NSObject, SettingsDataSource {
    
    var settingsPages: [Route] = [
        .savingSettings
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.nibName, for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .darkCellBg
        cell.textLabel?.text = settingsPages[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        
        return cell
    }
}
