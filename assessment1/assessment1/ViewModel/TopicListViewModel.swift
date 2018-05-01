//
//  TopicListViewModel.swift
//  assessment1
//
//  Created by Admin on 2018-04-30.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

struct TopicListCellViewModel {
    let titleText: String?
    let iconURL: URL?
}

class TopicListViewModel {

    let apiService: APIServiceProtocol
    private var topics = [Topic]()
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    private var cellViewModels: [TopicListCellViewModel] = [TopicListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func load() {
        self.isLoading = true
        apiService.loadTopics(success: { (topics) in
          self.isLoading = false
            self.topics = topics
            var viewModels = [TopicListCellViewModel]()
            for topic in topics {
                var iconURL:URL?
                if let icon = topic.icon?.url {
                    iconURL = URL(string: icon)
                }
                var titleText:String?
                if let text = topic.text {
                    titleText = text
                } else if let name = topic.name {
                    titleText = name
                }
                viewModels.append( TopicListCellViewModel(titleText: titleText, iconURL: iconURL))
            }
            self.cellViewModels = viewModels
        }) { (error) in
            self.isLoading = false
            self.alertMessage = error.rawValue
        }
    }
    
    func numberOfCells() -> Int {
        return self.cellViewModels.count
    }
    
    func getCellViewModel(at indexPath:IndexPath) -> TopicListCellViewModel {
        return self.cellViewModels[indexPath.row]
    }
}
