//
//  EditNoteView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 02.06.2024.
//

import SwiftUI


struct EditNoteView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    @Environment(\.dismiss) private var dismiss // moved dismiss functionality here

    @StateObject var viewModel: EditNoteViewModel
    
    
    @Binding var newItemPresented: Bool
    
    var currentItem : MoodItem
    
    @State private var title: String = "234234"
    
    
    enum FocusField: Hashable {
        case field
    }



    
    @FocusState private var focusedField: FocusField?

    
    
    init(currentItem: MoodItem, newItemPresented: Binding<Bool>) {

        self.currentItem = currentItem
        self._newItemPresented = newItemPresented
        
//        let id = currentItem.wrappedValue.id
//        let title = currentItem.wrappedValue.title
//        let date = currentItem.wrappedValue.date
//        let note = currentItem.wrappedValue.note
        _viewModel = StateObject(wrappedValue: EditNoteViewModel(moodItem:currentItem))
    }
    

    var body: some View {
        VStack {
            Text(currentItem.id)
            Text(currentItem.note ?? "Empty")
            TextField("Note", text: $viewModel.note,axis: .vertical)
                    .lineLimit(5...20)
                    .focused($focusedField, equals: .field)
                .textFieldStyle(DefaultTextFieldStyle())
            Spacer()
            FFButton(title: "Update", background: .black) {
                Task {
                    try await viewModel.save()
                    await homeViewModel.getMoodByDate(byDate: homeViewModel.dueDate)
                    dismiss()
                }
            }
        }
        .onAppear {
            self.focusedField = .field
        }
        .padding()
    }
}

#Preview {
    EditNoteView(currentItem: MoodItem(id: "23234234", title: "🙂", date: Date().timeIntervalSinceNow, note: ""), newItemPresented: .constant(true))
//    EditNoteView(viewModel: EditNoteViewModel(moodItem: <#T##MoodItem#>),newItemPresented: .constant(true),currentItem:.constant( MoodItem(id: "23234234", title: "🙂", date: Date().timeIntervalSinceNow, note: "")))
}
