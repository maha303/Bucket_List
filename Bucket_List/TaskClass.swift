//
//  TaskClass.swift
//  Bucket_List
//
//  Created by Maha saad on 19/05/1443 AH.
//

import Foundation

struct Task: Codable {
    let id: Int
    var objective, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, objective
        case createdAt = "created_at"
    }
}

//typealias Welcome = [Task]

