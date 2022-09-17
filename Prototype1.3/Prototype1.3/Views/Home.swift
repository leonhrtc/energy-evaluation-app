//
//  Home.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 14/08/2022.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var billModel: BillModel = .init()
//    @StateObject var roomModel: RoomModel = .init()
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    private var bills: FetchedResults<Bill>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.type, order: .reverse)])
    private var rooms: FetchedResults<Room>
    @State private var tabSelected = "Room"
    let segments = ["Room", "Cost"]
    @State private var showingBillView = false
    @State private var showingAlgoView = false
    @State private var showingHouseView = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12){
                HStack(spacing: 15){
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome to Heat Tracker")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.brown)
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
//                    NavigationLink {
//                        SettingView()
//                    } label: {
//                        Image(systemName: "hexagon.fill")
//                            .foregroundColor(.gray)
//                            .overlay(content: {
//                                Circle()
//                                    .stroke(.white,lineWidth: 2)
//                                    .padding(7)
//                            })
//                            .frame(width: 40, height: 40)
//                            .background(Color.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
//                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
//                    }
                }
                
                CardView().environmentObject(billModel)
                
                Picker("Choose tab", selection: $tabSelected) {
                            ForEach(segments, id:\.self) { segment in
                                Text(segment)
                                    .tag(segment)
                            }
                        }
                        .pickerStyle(.segmented)
                        .background(.brown)
                        .cornerRadius(10)
                        .padding()
                if tabSelected == "Room"{
                    roomList()
                }else{
                    billList()
                }
                

            }
            .padding()
        }
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay(alignment: .bottomTrailing) {
            billButton()
        }
        .overlay(alignment: .bottomLeading) {
            roomButton()
        }
    }
    

    
    @ViewBuilder
    func roomButton()->some View{
        Button {
            showingHouseView.toggle()
        } label: {
            Image(systemName: "house.fill")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
        .sheet(isPresented: $showingHouseView){AddRoomView()}
    }
    
    @ViewBuilder
    func algoButton()->some View{
        Button {
            showingAlgoView.toggle()
        } label: {
            Image(systemName: "function")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
        .sheet(isPresented: $showingAlgoView){AddRoomView()}
    }
    
    @ViewBuilder
    func billButton()->some View{
        Button {
            showingBillView.toggle()
        } label: {
            Image(systemName: "sterlingsign.circle")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
        .sheet(isPresented: $showingBillView){AddBillView()}
    }
    
    @ViewBuilder
    func roomList()->some View{
        VStack(alignment: .leading) {
            Text("Suggested heating power: \(Int(totalPower())) watt ")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding([.horizontal])
            NavigationView{
                List {
                    ForEach(rooms) { room in
                        NavigationLink(destination: EditRoomView(room: room)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(room.type!)
                                }
                                Spacer()
                                Text("suggested heating power: \((RoomModel().getHeatloss(room: room)), specifier: "%.1f") watt")
                                    .foregroundColor(.gray)
                                    .italic()
                                    .lineLimit(2)
                            }
                        }
                    }.onDelete(perform: deleteRoom)
                }.listStyle(.plain)
            }
        }

    }
    
    @ViewBuilder
    func billList()->some View{
        VStack(alignment: .leading) {
            Text("\(totalBillThisMonth(), specifier: "%.1f") £ (This Month)")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding([.horizontal])
            NavigationView{
                List {
                    ForEach(bills) { bill in
                        NavigationLink(destination: EditBillView(bill: bill)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("\((bill.amount), specifier: "%.1f")") + Text(" £").foregroundColor(.red)
                                }
                                Spacer()
                                Text(bill.date!.formatted(date: .abbreviated, time: .omitted))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }.onDelete(perform: deleteBill)
                }.listStyle(.plain)
            }
        }
    }
    
    private func deleteRoom(offsets: IndexSet) {
        withAnimation {
            offsets.map { rooms[$0] }
            .forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    
    private func deleteBill(offsets: IndexSet) {
        withAnimation {
            offsets.map { bills[$0] }
            .forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalPower() -> Double {
        var totalPower : Double = 0
        for item in rooms {
            totalPower += RoomModel().getHeatloss(room: item)
        }
        return totalPower
    }
    
    private func totalBillThisMonth() -> Double {
        var billThisMonth : Double = 0
        for item in bills {
            if item.date!.isInThisMonth{
                billThisMonth += item.amount
            }
        }
        print("Bill This Month: \(billThisMonth)")
        return billThisMonth
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
