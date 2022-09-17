//
//  AddRoomView.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 15/08/2022.
//

import SwiftUI

struct AddRoomView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @State private var type: String = ""
    
    @State private var width: String = ""
    @State private var length: String = ""
    @State private var height: String = ""
    

    @State private var inTemp: Double = 0
    @State private var outTemp: Double = 0
    
    @State private var floor: String = "0"
    @State private var roof: String = "0"
    @State private var wall: String = "0"
    @State private var wallNum: String = "0"
    @State private var window: String = "0"
    @State private var windowArea: String = ""
    
    @State private var acr: Double = 0

    


    
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
                    TextField("Width", text: $width).fixedSize().keyboardType(.numberPad)
                    TextField("Length", text: $length).fixedSize().keyboardType(.numberPad)
                    TextField("Height", text: $height).fixedSize().keyboardType(.numberPad)
                    
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
                    
                    Picker("Outside the wall", selection: $wall, content: {
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
                    Picker("Window type", selection: $window, content: {
                        Text("wood single glazed").tag("0")
                        Text("metal single glazed").tag("1")
                        Text("metal double glazed").tag("2")
                        Text("wood/plastic double glazed").tag("3")
                    })
                    
                    TextField("Window area", text: $windowArea).fixedSize().keyboardType(.numberPad)

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
            Button(action: {DataController().addRoom(type: type, width: width, length: length, height: height, inTemp: inTemp, outTemp: outTemp, floor: floor, roof: roof, wall: wall, wallNum: wallNum, window: window, windowArea: windowArea, acr: acr, context: managedObjContext);dismiss()}) {
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
            .disabled(width == "" || length == "" || height == "" || windowArea == "" )
            .opacity(width == "" || length == "" || height == "" || windowArea == "" ? 0.6 : 1)
            }        .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Color("BG")
                    .ignoresSafeArea()
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                        .opacity(0.7)
                }
                .padding()
            }
            
          
    }
    
}

struct AddRoomView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoomView()
    }
}
