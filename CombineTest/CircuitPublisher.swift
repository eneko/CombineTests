//
//  TimePublisher.swift
//  CombineTest
//
//  Created by Eneko Alonso on 7/6/19.
//  Copyright © 2019 Eneko Alonso. All rights reserved.
//

import Foundation
import Combine

struct Circuit: Codable {
    let name: String
}

enum RequestError: Error {
    case badRequest
}

struct CircuitPublisher {
    let url = URL(string: "https://www.grandprixstats.org/api/v1/f1/circuits/all.json")!
    var publisher: AnyPublisher<[Circuit], Error> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap {
                guard let response = $1 as? HTTPURLResponse, response.statusCode == 200 else {
                    throw RequestError.badRequest
                }
                return $0
            }
            .decode(type: [Circuit].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
