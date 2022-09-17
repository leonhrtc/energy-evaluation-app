////
////  EvaluationView.swift
////  Prototype1.3
////
////  Created by 雷定霏 on 15/08/2022.
////
//
//import SwiftUI
//
//struct SettingView: View {
//    @Environment(\.managedObjectContext) var managedObjContext
//    @Environment(\.dismiss) var dismiss
//    @State private var price: String = "0"
//    @State private var powerRate: Double = 0
//    var body: some View {
//        VStack{
//
//            Text("Add Energy Details")
//                .font(.title2)
//                .fontWeight(.semibold)
//                .opacity(0.5)
//            List {
//
//
//                Section {
//                    TextField("Price", text: $price).fixedSize().keyboardType(.numberPad)
//
//                } header: {
//                    Text("price of 1 kWh (£)")
//                }
//                Section {
//                    Slider(value: $powerRate, in: 0...100)
//                    Text("The effictive power rate is:   \(powerRate, specifier: "%.1f") %").font(.system(size: 15))
//
//                } header: {
//                    Text("Heater's effictive Power Rate")
//                }
//
//            }
//            Button(action: {
//                DataController().addEva(price: price, powerRate: powerRate, context: managedObjContext);dismiss()}) {
//            Text("Save")
//                .foregroundColor(.black)
//                .font(.title3)
//                .fontWeight(.semibold)
//                .padding(.vertical,14)
//                .frame(maxWidth: .infinity)
//                .background{
//                    RoundedRectangle(cornerRadius: 12, style: .continuous)
//                        .fill(
//                            LinearGradient(colors: [
//                                Color("Gradient1"),
//                                Color("Gradient2"),
//                                Color("Gradient3"),
//                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
//                        )
//                }
//                .padding(.bottom,5)
//        }
//        .disabled(price == "0" || powerRate == 0 )
//        .opacity(price == "0" || powerRate == 0  ? 0.6 : 1)
//            }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//        .overlay(alignment: .topTrailing) {
//            Button {
//                dismiss()
//            } label: {
//                Image(systemName: "xmark")
//                    .font(.title2)
//                    .foregroundColor(.black)
//                    .opacity(0.7)
//            }
//            .padding()
//        }
//
//    }
//}
//
//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
