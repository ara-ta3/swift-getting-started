//
//  Gateway.swift
//  HelloSwift
//
//  Created by 田中改 on 2020/03/11.
//  Copyright © 2020 Aratoon. All rights reserved.
//

import Foundation
import Alamofire

class EventGateway {
    let eventOrigin: String
    init(eventOrigin: String) {
        self.eventOrigin = eventOrigin;
    }
        
    func fetchEvents(completion: @escaping (Result<[Event], AFError>) -> ()) {
        AF.request("\(self.eventOrigin)/events/search")
            .responseDecodable(of: EventSearchResponseBody.self) {res in
                switch(res.result) {
                case .success(let searchResult):
                    let params: [String: [String]] = [
                        "eventUuids": searchResult.eventUuids
                    ]
                    AF.request("\(self.eventOrigin)/events/details", method: .post, parameters: params, encoder: JSONParameterEncoder.default)
                        .responseDecodable(of: EventDetailResponseBody.self) { res in
                            let events = res.result.map { (details: EventDetailResponseBody) in return details.events }
                            completion(events)
                    }
                case .failure(let e):
                    completion(.failure(e))
                }
        }
    }
}

struct EventSearchResponseBody: Decodable { let eventUuids: Array<String>}

struct EventDetailResponseBody: Decodable { let events: Array<Event>}

struct Event: Decodable {
    let name: String
    let uuid: String
}
