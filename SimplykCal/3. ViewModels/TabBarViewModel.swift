//
//  TabBarDataModel.swift
//  SimplykCal
//
//  Created by Eduard Costache on 05/06/2025.
//

import Observation

@Observable
class TabBarViewModel {
    var isShowing: Bool = true
    var showAddFoodSheet: Bool = false
    var selectedTab: Int = 0
}
