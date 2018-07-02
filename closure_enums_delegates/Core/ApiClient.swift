//
//  ApiClient.swift
//  unit-test-dependencies-tutorial
//
//  Created by David Martinez-Lebron on 1/1/18.
//  Copyright © 2018 David Martinez-Lebron. All rights reserved.
//

import UIKit

enum Constants {
    static let jobsUrl = "https://jobs.github.com/positions.json"
}

protocol ApiClientDelegate {
    func didFinishLoadingWithJobs(_ jobs: [Job]?)
    func didFailedLoadingWithError(_ error: ApiClientError)
}

enum ApiClientError: Error {
    case jsonFormat(String)
    case responseError(String)
}

final class ApiClient {

    let delegate: ApiClientDelegate

    init(delegate: ApiClientDelegate) {
        self.delegate = delegate
    }

    func get(url: URL) {

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.delegate.didFailedLoadingWithError(ApiClientError.responseError("Generic Error"))
                }
                return
            }

            do {
                let jobs = try JSONDecoder().decode([Job].self, from: data)

                DispatchQueue.main.async {
                    self?.delegate.didFinishLoadingWithJobs(jobs)
                }

                } catch let error {

                DispatchQueue.main.async {
                    self?.delegate.didFailedLoadingWithError(ApiClientError.jsonFormat(error.localizedDescription))
                }
            }
            }.resume()
    }
}

