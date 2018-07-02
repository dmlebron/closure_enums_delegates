//
//  ViewModel.swift
//  closure_enums_delegates
//
//  Created by David Martinez-Lebron on 6/28/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import UIKit

protocol ViewModelDelegate {
    func didFailedWithError(_ error: ViewModelError)
    func didFinishLoadingWithJobs(_ jobs: [Job]?)
}

enum ViewModelError: Error {
    case urlError(String)
    case apiClientError(ApiClientError)
}

final class ViewModel {
    let delegate: ViewModelDelegate

    lazy var apiClient = ApiClient(delegate: self)

    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }

    func getJobs() {
        
        guard let url = URL(string: Constants.jobsUrl) else {
            delegate.didFailedWithError(ViewModelError.urlError("Invalid url"))
            return
        }

        apiClient.get(url: url)
    }
}

extension ViewModel: ApiClientDelegate {
    func didFinishLoadingWithJobs(_ jobs: [Job]?) {
        delegate.didFinishLoadingWithJobs(jobs)
    }

    func didFailedLoadingWithError(_ error: ApiClientError) {

    }
}
