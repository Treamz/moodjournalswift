//
//  EditNoteViewModel.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 02.06.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class EditNoteViewModel : ObservableObject {
    @Published var moodItem : MoodItem
    
    @Published var note = ""
    
    init(moodItem: MoodItem) {
        self.moodItem = moodItem
        self.note = moodItem.note ?? ""
    }
    
    func save() async throws {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        do {
            try await db.collection("users").document(userId).collection("moods").document(moodItem.id).updateData(["note" : note])
        }
        catch {
            print("ERROR: \(error.localizedDescription)")
        }
        print("Save new note")
    }
}
