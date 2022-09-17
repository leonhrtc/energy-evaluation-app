//
//  CardView.swift
//  Prototype1.3
//
//  Created by 雷定霏 on 14/08/2022.
//

import SwiftUI
import CoreML

struct CardView: View {
    @EnvironmentObject var billModel: BillModel
    @EnvironmentObject var roomModel: RoomModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var bills: FetchedResults<Bill>
    var isFilter: Bool = false
    var body: some View {
        GeometryReader{proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .linearGradient(colors: [
                        Color("Gradient1"),
                        Color("Gradient2"),
                        Color("Gradient3"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            VStack(spacing: 15){
                VStack(spacing: 15){
                    Text(EvaluationModel().getWeeklyTip(bills: bills))
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.bottom,5)
                    Text(isFilter ? billModel.convertDateToString() : billModel.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .offset(y: -10)
                
                HStack(spacing: 15){
                    Image(systemName: "sun.max.fill")
                        .font(.caption.bold())
                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.9),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("power")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("\((EvaluationModel().getPower(bills: bills)), specifier: "%.1f") watt")
                            .font(.caption)

                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Image(systemName: "sterlingsign.circle")
                        .font(.caption.bold())
                        .foregroundColor(.green)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.9),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("expense")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Weekly: \((EvaluationModel().getWeeklyBill(bills: bills)), specifier: "%.1f") £")
                            .font(.caption)
                            .lineLimit(1)
                            .fixedSize()
                        Text("Average: \((EvaluationModel().getAverageBill(bills: bills)), specifier: "%.1f") £")
                            .font(.caption)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 220)
        .padding(.top)
    }
}
