//
//  Job.swift
//  closure_enums_delegates
//
//  Created by David Martinez-Lebron on 6/28/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import Foundation

struct Job: Codable {
    let id: String
    let createdAt: String?
    let title: String?
    let location: String?
    let type: String?
    let description: String?
    let howToApply: String?
    let company: String?
    let companyUrl: String?
    let companyLogo: String?
    let urlString: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case title = "title"
        case location = "location"
        case type = "type"
        case description = "description"
        case howToApply = "how_to_apply"
        case company = "company"
        case companyUrl = "company_url"
        case companyLogo = "company_logo"
        case urlString = "url"
    }
}
