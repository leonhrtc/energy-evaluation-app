//
//  RoomModel.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 24/08/2022.
//

import Foundation
import CoreData


class RoomModel: ObservableObject{
    let container = NSPersistentContainer(name: "Prototype1_3")
    // q value reference
    var floorValue = [ "0": 0.12,
                       "1": 0.15,
                       "2": 0.20
    ]
    var roofValue = [ "0": 0.12,
                      "1": 2.5,
                       "2": 0.18,
                      "3": 1.5,
                       "4": 0.18
    ]
    var wallValue = [ "0": 2.0,
                      "1": 1.5,
                      "2": 0.18,
                       "3": 0.29,
    ]
    var windowValue = [ "0": 4.8,
                        "1": 5.8,
                        "2": 3.4,
                        "3": 2.8,
    ]
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func getHeatloss(room: Room) -> Double{
        //q value
        let volume: Double = room.length*room.width*room.height
        let differ: Double = abs(room.outTemp - room.inTemp)
        let floor: Double = floorValue[room.floor!]!
        let roof: Double = roofValue[room.roof!]!
        let wall: Double = wallValue[room.wall!]!
        let window: Double = windowValue[room.window!]!
        
        //area
        let area: Double = room.length*room.width
        let wallArea: Double = (room.length + room.height)*0.5*room.height*Double(room.wallNum)
        
        //heat loss
        let fabricHeatloss = (floor+roof)*area + wall*wallArea + window*room.windowArea
        let airHeatloss = 0.33*room.acr*volume
        return (fabricHeatloss + airHeatloss)*differ
    }
    
}
