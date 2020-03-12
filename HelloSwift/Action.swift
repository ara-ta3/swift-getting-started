//
//  Action.swift
//  HelloSwift
//
//  Created by 田中改 on 2020/03/12.
//  Copyright © 2020 Aratoon. All rights reserved.
//

import ReSwift

struct FetchEventsFinish: Action {
    let events: Array<Event>;
    
    init(events: Array<Event>) {
        self.events = events
    }
}

struct FetchEventsStart: Action {}

struct FetchEventsFailed: Action {
    let error: Error
    
    init(error: Error) {
        self.error = error
    }
}
