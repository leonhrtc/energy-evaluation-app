//
//  BillModel.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 14/08/2022.
//

import SwiftUI

class BillModel: ObservableObject{
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    @Published var showFilterView: Bool = false

    @Published var addNewExpense: Bool = false
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var remark: String = ""
    
    init(){
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: Date())
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    
    func currentMonthDateString()->String{
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    

    func convertDateToString()->String{
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
}
