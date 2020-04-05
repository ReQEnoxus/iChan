//
//  ThreadSelectorDataSourceOutput.swift
//  iChan
//
//  Created by Enoxus on 29/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorDataSourceOutput: AnyObject {
    
    /// tells presenter that particular image was tapped by user
    /// - Parameter attachment: attachment to be displayed fullscrren
    func didTapImage(with attachment: AttachmentDto)
    
    /// tells presenter that textview is tapped
    func didTapTextView(at indexPath: IndexPath)
    
    /// tells presenter that url inside of thread cell was tapped
    /// - Parameter url: tapped url
    func didTapUrl(url: URL)
}
