//
//  SavingSettingsDataSourceImpl.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SavingSettingsDataSourceImpl: NSObject, SavingSettingsDataSource {
    
    private class Constants {
        
        static let textOnly = "Только текст"
        static let textAndPics = "Текст и картинки"
        static let textAndAllAttachments = "Все вложения"
    }
    
    var options: [Option] = [
        
        Option(name: Constants.textOnly, isSelected: false),
        Option(name: Constants.textAndPics, isSelected: false),
        Option(name: Constants.textAndAllAttachments, isSelected: false)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.nibName, for: indexPath)
        
        cell.backgroundColor = .darkCellBg
        cell.textLabel?.text = options[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.tintColor = .orangeUi
        cell.accessoryType = options[indexPath.row].isSelected ? .checkmark : .none
        
        return cell
    }
}
