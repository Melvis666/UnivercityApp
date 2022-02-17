//
//  UniversityModel.swift
//  UnivercityApp
//
//  Created by Назар Гузар on 16.02.2022.
//

import Foundation

struct UniversityModel: Codable {
    
    let name: String
    let country: String
    let alphaTwoCode: String
    let stateProvince: String?
    let webPageURL: [String]

    
    private enum CodingKeys: String, CodingKey {
        case country, name
        case alphaTwoCode = "alpha_two_code"
        case stateProvince = "state-province"
        case webPageURL = "web_pages"
    }
}
