//
//  Epic.swift
//  HelloSwift
//
//  Created by 田中改 on 2020/03/12.
//  Copyright © 2020 Aratoon. All rights reserved.
//

import ReSwift
import Alamofire

func fetchEvents(
    store: Store<AppState>,
    eventGateway: EventGateway
) {
    eventGateway.fetchEvents(completion: { (result: Result<[Event], AFError>) in
        switch(result) {
        case .success(let events):
            store.dispatch(FetchEventsFinish(events: events))
        case .failure(let e):
            debugPrint(e)
        }
    })
}

