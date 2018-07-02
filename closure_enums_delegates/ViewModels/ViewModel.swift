//
//  ViewModel.swift
//  closure_enums_delegates
//
//  Created by David Martinez-Lebron on 6/28/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import UIKit

enum ViewModelError: Error {
    case urlError(String)
    case apiClientError(ApiClientError)
}

final class ViewModel {

    typealias Closure = (Result) -> ()

    enum Result {
        case jobs([Job])
        case error(ViewModelError)
    }

    let apiClient = ApiClient()

    func getJobs(closure: @escaping Closure) {
        
        guard let url = URL(string: Constants.jobsUrl) else {
            closure(Result.error(ViewModelError.urlError("Invalid url")))
            return
        }

        apiClient.get(url: url) { (response) in
            switch response {
            case .error(let error):
                closure(Result.error(.apiClientError(error)))

            case .result(let jobs):
                closure(Result.jobs(jobs))
            }
        }
    }
}
