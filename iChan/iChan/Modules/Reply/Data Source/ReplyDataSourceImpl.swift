//
//  ReplyDataSourceImpl.swift
//  iChan
//
//  Created by Enoxus on 08.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyDataSourceImpl: NSObject, ReplyDataSource, AttachmentCellDelegate {
    
    var attachments: [PostAttachment] = []
    
    weak var presenter: ReplyDataSourceOutput!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostAttachmentCell.nibName) as! PostAttachmentCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.configure(with: attachments[indexPath.row], delegate: self)
        
        return cell
    }
    
    func deleteButtonPressed(on attachment: PostAttachment) {
        presenter.deleteButtonPressed(on: attachment.id)
    }
}
