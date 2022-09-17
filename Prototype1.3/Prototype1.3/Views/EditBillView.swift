//
//  EditBillView.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 15/08/2022.
//

import SwiftUI

struct EditBillView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var bill: FetchedResults<Bill>.Element
    
    @State private var amount: Double = 0
    @State private var date: Date = Date()

    var body: some View {
        VStack{
            VStack(spacing: 15){
                Text("Edit Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                
                // For Currency Symbol
                if let symbol = convertNumberToPrice(value: 0).first{
                    TextField("0", value: $amount, formatter: NumberFormatter())
                        .font(.system(size: 35))
                        .foregroundColor(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            Text(amount == 0 ? "0" : String(amount))
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading) {
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        }
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal,20)
                        .padding(.top)
                }
                
                
                Label {
                    DatePicker.init("", selection: $date,in: Date.distantPast...Date(),displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top,5)
            }
            .frame(maxHeight: .infinity,alignment: .center)
            
            // MARK: Save Button
            Button(action: {DataController().editBill(bill: bill, date: date, amount: amount, context: managedObjContext)}) {
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
            .disabled(amount == 0)
            .opacity(amount == 0 ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
    }
    
    func convertNumberToPrice(value: Double)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "£0.00"
    }
}

