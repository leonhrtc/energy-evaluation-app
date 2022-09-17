//
//  EditRoomView.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 15/08/2022.
//



import SwiftUI

struct EditRoomView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    var room: FetchedResults<Room>.Element
    @State private var type: String
    
    @State private var width: String
    @State private var length: String
    @State private var height: String
    

    @State private var inTemp: Double
    @State private var outTemp: Double
    
    @State private var floor: String
    @State private var roof: String
    @State private var wall: String
    @State private var wallNum: String
    @State private var window: String
    @State private var windowArea: String
    
    @State private var acr: Double = 0

    init(room: Room) {
        self.room = room
        self._type = State(initialValue: room.type!)
        self._width = State(initialValue: String(room.width))
        _length = State(initialValue: String(room.length))
        _height = State(initialValue: String(room.height))
        _inTemp = State(initialValue: room.inTemp)
        _outTemp = State(initialValue: room.outTemp)
        _floor = State(initialValue: room.floor!)
        _roof = State(initialValue: room.roof!)
        _wall = State(initialValue: room.wall!)
        _wallNum = State(initialValue: String(room.wallNum))
        _window = State(initialValue: room.window!)
        _windowArea = State(initialValue: String(room.windowArea))
        _acr = State(initialValue: room.acr)

    }


    
    var body: some View {
        VStack{

            Text("Add Room Details")
                .font(.title2)
                .fontWeight(.semibold)
                .opacity(0.5)
            List {
                Section {
                    Picker("Heating area", selection: $type, content: {
                        Text("bathroom").tag("bathroom")
                        Text("bedroom").tag("bedroom")
                        Text("kitchen").tag("kitchen")
                        Text("livingroom").tag("livingroom")
                        Text("other place").tag("other place")
                    })

                } header: {
                    Text("Select a room type")
                }
                
                Section {
                    TextField(width, text: $width).fixedSize().keyboardType(.decimalPad)
                    TextField(length, text: $length).fixedSize().keyboardType(.decimalPad)
                    TextField(height, text: $height).fixedSize().keyboardType(.decimalPad)
                    
                } header: {
                    Text("Room Size (m)")
                }
                
                Section {
                    Slider(value: $inTemp, in: -50...50)
                    Text("Tempreture inside:   \(inTemp, specifier: "%.1f") Celsius").font(.system(size: 15))
                    Slider(value: $outTemp, in: -50...50)
                    Text("Tempreture outside:   \(outTemp, specifier: "%.1f") Celsius").font(.system(size: 15))

                } header: {
                    Text("Tempreture (Celsius)")
                }
                
                Section {
                    Picker("Below the floor", selection: $floor, content: {
                        Text("heated room").tag("0")
                        Text("wooden").tag("1")
                        Text("concrete").tag("2")
                    })
                    
                    Picker("Above the roof", selection: $roof, content: {
                        Text("heated room").tag("0")
                        Text("pitched roof uninsulated").tag("1")
                        Text("pitched roof insulated").tag("2")
                        Text("flat roof uninsulated").tag("3")
                        Text("flat roof insulated").tag("4")
                    })
                    
                    Picker("Outside walls", selection: $wall, content: {
                        Text("solid brick").tag("0")
                        Text("brick cavity uninsulated").tag("1")
                        Text("brick cavity insulated").tag("2")
                        Text("wood frame").tag("3")
                    })
                    
                    Picker("Number of outside walls", selection: $wallNum, content: {
                        Text("0").tag("0")
                        Text("1").tag("1")
                        Text("2").tag("2")
                        Text("3").tag("3")

                    })
                    
                    Picker("Windows type", selection: $window, content: {
                        Text("Wood single glazed").tag("0")
                        Text("Metal single glazed").tag("1")
                        Text("Metal double glazed").tag("2")
                        Text("Wood/Plastic double glazed").tag("3")
                    })
                    
                    TextField(windowArea, text: $windowArea).fixedSize().keyboardType(.decimalPad)

                } header: {
                    Text("House fabric elements")
                }
                
                Section {
                    Slider(value: $acr, in: 0...20)
                    Text("The air change rate is:   \(acr, specifier: "%.1f") time(s) per hour").font(.system(size: 15))

                } header: {
                    Text("Air Change Rate (optional)")
                }


            }
            Button(action: {DataController().editRoom(room: room, type: type, width: width, length: length, height: height, inTemp: inTemp, outTemp: outTemp, floor: floor, roof: roof, wall: wall, wallNum: wallNum, window: window, windowArea: windowArea, acr: acr, context: managedObjContext);dismiss()}) {
                Text("Save")
                    .foregroundColor(.black)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical,14)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(colors: [
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3"),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                    .padding(.bottom,5)
            }
            .disabled(width == "0" || length == "0" || height == "0")
            .opacity(width == "0" || length == "0" || height == "0" ? 0.6 : 1)
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Color("BG")
                    .ignoresSafeArea()
            }
          
    }
    
}

