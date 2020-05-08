//
//  ReplyViewInput.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyViewInput: AnyObject {
    
    /// tells view to set initial text in the message text view
    /// - Parameter text: text to set
    func setInitialMessageText(_ text: String)
    
    /// tells view that given id should be validated
    /// - Parameter id: recaptcha public id
    func validationRequested(on id: String)
    
    /// tells view to display loading indicator
    func displayLoadingIndicator()
    
    /// tells view to turn loading indicator into an error indicator with given message
    /// - Parameter message: error message
    func displayErrorMessage(_ message: String)
    
    /// tells view to dismiss loading view
    func dismissLoadingView()
    
    /// tells view to assign given datasource to attachments table view
    /// - Parameter dataSource: datasource to be assigned
    func registerDataSourceForAttachmentsTable(_ dataSource: ReplyDataSource)
    
    /// tells view to completely reload attachments table view data
    func reloadAttachmentsData()
    
    /// tells view to partly reload attachments table view data
    /// - Parameters:
    ///   - deletions: indices of deleted elements
    ///   - insertions: indices of inserted elements
    func reloadAttachmentsData(deletions: [IndexPath], insertions: [IndexPath])
}
