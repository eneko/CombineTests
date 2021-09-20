//
//  TimePublisher.swift
//  CombineTest
//
//  Created by Eneko Alonso on 7/8/19.
//  Copyright © 2019 Eneko Alonso. All rights reserved.
//

import Foundation
import Combine


//let url = URL(
//var timePublisher = 

struct TimeInfo: Codable {
    let datetime: String
}

struct TimePublisher {
    static let shared = TimePublisher()

    let url = URL(string: "https://worldtimeapi.org/api/ip")!
    var publisher: AnyPublisher<TimeInfo, Error> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap {
                guard let response = $1 as? HTTPURLResponse, response.statusCode == 200 else {
                    throw RequestError.badRequest
                }
                return $0
        }
        .decode(type: TimeInfo.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
