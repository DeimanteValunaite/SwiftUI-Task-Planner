//
//  TaskSheetView.swift
//  TaskPlanner
//
//  Created by Deimante Valunaite on 20/04/2024.
//

import SwiftUI
import SwiftData

struct TaskSheetView: View {
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button {
                            let task = Task(title: taskTitle, date: taskDate)
                            do {
                                context.insert(task)
                                try context.save()
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Text("Add")
                                .foregroundColor(.primary)
                        }
                        
//                        Button(action: {
//                            dismiss()
//                        }, label: {
//                            Image(systemName: "x.circle.fill")
//                                .foregroundColor(.secondary)
//                        })
//                        .font(.system(size: 18))
                    }
                    
                    Spacer()
                    
                    Text("Task Title")
                        .font(.body)
                        .padding(.top, 10)
                        .foregroundColor(Color.primary)
                    
                    TextField("  Your Task Title", text: $taskTitle)
                        .font(.body)
                        .frame(height: 35)
                        .background(.secondary)
                    //    .background(Color.primary.opacity(0.2))
                        .foregroundColor(Color.secondaryText)
                        .cornerRadius(6)
                    
                    Text("Task Date")
                        .font(.body)
                        .foregroundColor(Color.primary)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
                
                Button {
                    let task = Task(title: taskTitle, date: taskDate)
                    do {
                        context.insert(task)
                        try context.save()
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .foregroundColor(Color.accentColor)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .padding(.bottom)
    }
}

#Preview {
    TaskSheetView()
}
