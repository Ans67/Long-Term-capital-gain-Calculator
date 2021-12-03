//  AddManager.swift
//  LONG TERM CAPITAL GAINS Calculator
//
//  Created by Anas Mansuri on 20/07/19.
//  Copyright © 2019 Anas Mansuri. All rights reserved.
//

import Foundation

class AddManager {
    
    // MARK: - Properties
    static let shared = AddManager()
    var totalItems: [AddData] = []

    private let defaults = UserDefaults.standard
    
    private init() {
        if let data = UserDefaults.standard.object(forKey: "addData") as? Data {
            totalItems = (try? JSONDecoder().decode([AddData].self, from: data)) ?? []
        }
    }
    
    func add(new:AddData) {
        totalItems = totalItems.filter { $0.itemNo != new.itemNo }
        totalItems.append(new)
       // saveAllData()
    }
    
    func deleteItem(_ item: Int) {
        totalItems.remove(at: item)
    }
    
    func saveAllData() {
        if let encoded = try? JSONEncoder().encode(totalItems) {
            UserDefaults.standard.set(encoded, forKey: "addData")
        }
    }

}
