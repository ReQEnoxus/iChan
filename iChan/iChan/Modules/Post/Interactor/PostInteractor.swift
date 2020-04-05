//
//  PostInteractor.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PostInteractor: PostInteractorInput {
    
    weak var presenter: PostInteractorOutput!
    var urlService: UrlCheckerService!
    
    //MARK: - Interactor Input
    func didTapUrl(url: URL) {
        presenter.didFinishCheckingUrl(type: urlService.typeOf(url: url))
    }
}
