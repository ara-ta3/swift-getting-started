//
//  Reducer.swift
//  HelloSwift
//
//  Created by 田中改 on 2020/03/12.
//  Copyright © 2020 Aratoon. All rights reserved.
//

import ReSwift

func eventList(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    case _ as FetchEventsStart: state.loading = true
    case let action as FetchEventsFinish: do {
        state.events = action.events
        state.loading = false
    }
    case _ as FetchEventsFinish: state.loading = false
    default: break
    }
    
    return state
}
