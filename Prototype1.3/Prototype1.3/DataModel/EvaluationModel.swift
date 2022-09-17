//
//  EvaluationModel.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 25/08/2022.
//

import Foundation
import CoreData
import SwiftUI


class EvaluationModel: ObservableObject{
    let container = NSPersistentContainer(name: "Prototype1.3")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func getAverageBill(bills: FetchedResults<Bill>) -> Double {
        var bill : Double = 0
        var count: Double = 0
        for item in bills {
            bill += item.amount
            count += 1
        }
        if bill == 0 || count == 0{
            return 0
        }
        return bill/count
    }
    
    func getWeeklyBill(bills: FetchedResults<Bill>) -> Double {
        var bill: Double = 0
        var count: Double = 0
        for item in bills {
            if item.date!.isInThisWeek{
                bill += item.amount
                count += 1
            }
        }
        if bill == 0 || count == 0{
            return 0
        }
        return bill/count
    }
    
    func getWeeklyTip(bills: FetchedResults<Bill>) -> String {
        let avg = EvaluationModel().getAverageBill(bills: bills)
        let avg_7 = EvaluationModel().getWeeklyBill(bills: bills)
        if abs(avg_7-avg)<0.05*avg{
            return "cost remains the same"
        }else{
            if avg_7>avg{
                return "cost increases this week"
            }
            else if avg_7 == 0{
                return "enter data to get advice"
            }else if avg_7 <= avg{
                return "cost decreases this week"
            }
            else{
                return ""
            }
        }
    }
    
    func getPower(bills: FetchedResults<Bill>) -> Double{
        let avg = EvaluationModel().getAverageBill(bills: bills)
        let power = avg*1000*7*2.8/24  // energy price * 1000 (power rate * working hour)(24?)
        if power.isNaN{         // now the gas price is 0.15£/kWh, so here *7 insead of /0.15
            return 0
        }
        return power
    }
    
}
