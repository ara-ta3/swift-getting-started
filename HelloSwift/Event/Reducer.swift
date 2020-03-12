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
    case let action as FetchEventsFinish: state.events = action.events
    default: break
    }
    
    return state
}
