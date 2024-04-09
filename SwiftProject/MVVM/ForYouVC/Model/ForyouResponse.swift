//
//  ForyouResponse.swift
//  SwiftProject
//
//  Created by Admin on 02/04/24.
//

import Foundation

struct ForyouResponse: Decodable{
    let data: [ForyouResponseData]?
}

struct ForyouResponseData: Decodable{
    let id: Int?
    let status: String?
    let sort: String?
    let user_created, date_created, user_updated, date_updated: String?
    let name, artist, accent, cover: String?
    let top_track: Bool?
    let url: String?
}
