//
//  WeekHeaderView.swift
//  TaskPlanner
//
//  Created by Deimante Valunaite on 20/04/2024.
//

import SwiftUI

struct WeekHeaderView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @State var currentDate: Date = .init()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        TabView(selection: $viewModel.currentIndex) {
            ZStack {
                ForEach(viewModel.allWeeks) { week in
                    VStack {
                        HStack(spacing: 0) {
                            ForEach(0..<7) { index in
                                VStack(spacing: 10) {
                                    Text(viewModel.dateToString(date: week.date[index], format: "E"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity)
                                    Text(viewModel.dateToString(date: week.date[index], format: "dd"))
                                        .font(.system(size: 14))
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(viewModel.isToday(date: week.date[index]) ? Color.black : Color.theme.secondaryText)
                                        .fontWeight(.bold)
                                        .background {
                                            if viewModel.isCurrentDate(week.date[index], currentDate) {
                                                Circle()
                                                    .fill(.primary)
                                                    .frame(width: 5)
                                                    .offset(y: 24)
                                            }
                                            
                                            if viewModel.isToday(date: week.date[index]) {
                                                Circle()
                                                    .fill(.primary)
                                                    .frame(width: 35, height: 30)
                                            }
                                        }
                                }
                                .tag(index)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        viewModel.currentDate = week.date[index]
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(height: 80)
                        .background(
                            Rectangle()
                                .fill(.accent)
                        )
              //          .padding()
                        
                        Divider()
                            .overlay(.primary)
                    }
                    .offset(x: screenOffset(week.id), y: 0)
                    .zIndex(1.0 - abs(distance(week.id)) * 0.1)
                    .padding()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .accentColor(Color.theme.background)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.snappy) {
                        draggingItem = snappedItem + value.translation.width / 400
                    }
                }
                .onEnded { value in
                    withAnimation(.snappy) {
                        if value.predictedEndTranslation.width > 0 {
                            draggingItem = snappedItem + 1
                        } else {
                            draggingItem = snappedItem - 1
                        }
                        snappedItem = draggingItem
                        viewModel.update(index: Int(snappedItem))
                    }
                }
        )
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear {
            viewModel.currentIndex = min(max(viewModel.currentIndex, 0), viewModel.allWeeks.count - 1)
        }
        .preferredColorScheme(.dark)
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(viewModel.allWeeks.count))
    }
    
    func screenOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(viewModel.allWeeks.count) * distance(item)
        return sin(angle) * 200
    }
}

#Preview {
    WeekHeaderView()
}
