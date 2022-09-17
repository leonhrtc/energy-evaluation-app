//
//  DataSample.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 17/08/2022.
//

import Foundation

struct Bill_Model: Identifiable,Hashable{
    var id = UUID().uuidString
    var amount: Double
    var date: Date
}


var sample_expenses: [Bill_Model] = [
    Bill_Model(amount: 99, date: Date(timeIntervalSince1970: 1652987245)),
    Bill_Model(amount: 19, date: Date(timeIntervalSince1970: 1652814445)),
    Bill_Model(amount: 99, date: Date(timeIntervalSince1970: 1652382445)),
]
