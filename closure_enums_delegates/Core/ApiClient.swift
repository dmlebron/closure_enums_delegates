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

enum ApiClientError: Error {
    case jsonFormat(String)
    case responseError(String)
}

final class ApiClient {

    typealias Closure = (Response) -> ()

    enum Response {
        case result([Job])
        case error(ApiClientError)
    }

    func get(url: URL, closure: @escaping Closure) {

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    closure(Response.error(ApiClientError.responseError("Generic Error")))
                }
                return
            }

            do {
                let jobs = try JSONDecoder().decode([Job].self, from: data)

                DispatchQueue.main.async {
                    closure(Response.result(jobs))
                }

                } catch let error {

                DispatchQueue.main.async {
                    closure(Response.error(.jsonFormat(error.localizedDescription)))
                }
            }
            }.resume()
    }
}

