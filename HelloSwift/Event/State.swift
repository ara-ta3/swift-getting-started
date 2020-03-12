//
//  State.swift
//  HelloSwift
//
//  Created by 田中改 on 2020/03/12.
//  Copyright © 2020 Aratoon. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var loading: Bool = false
    var events: Array<Event> = []
}
