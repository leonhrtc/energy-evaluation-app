//
//  DataController.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 14/08/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Prototype1.3")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
//
    func addRoom(type: String, width: String, length: String, height: String, inTemp: Double,outTemp: Double, floor: String,roof: String, wall: String, wallNum: String, window: String,windowArea: String,acr: Double, context: NSManagedObjectContext) {
        let room = Room(context: context)
        room.id = UUID()
        room.type = type
        room.width = Double(width)!
        room.length = Double(length)!
        room.height = Double(height)!
        room.inTemp = inTemp
        room.outTemp = outTemp
        room.floor = floor
        room.roof = roof
        room.wall = wall
        room.wallNum = Int16(wallNum)!
        room.window = window
        room.windowArea = Double(windowArea)!
        room.acr = acr
        save(context: context)
    }
//
    func editRoom(room: Room, type: String, width: String, length: String, height: String, inTemp: Double,outTemp: Double, floor: String,roof: String, wall: String, wallNum: String, window: String,windowArea: String,acr: Double, context: NSManagedObjectContext) {
        room.type = type
        room.width = Double(width)!
        room.length = Double(length)!
        room.height = Double(height)!
        room.inTemp = inTemp
        room.outTemp = outTemp
        room.floor = floor
        room.roof = roof
        room.wall = wall
        room.wallNum = Int16(wallNum)!
        room.window = window
        room.windowArea = Double(windowArea)!
        room.acr = acr
        save(context: context)
    }
    
    func addBill(amount: Double, date: Date, context: NSManagedObjectContext){
        let bill = Bill(context: context)
        bill.id = UUID()
        bill.amount = amount
        bill.date = date
        save(context: context)
    }
    
    func editBill(bill: Bill, date: Date, amount: Double, context: NSManagedObjectContext){
        bill.amount = amount
        bill.date = date
        save(context: context)
    }
    
}
