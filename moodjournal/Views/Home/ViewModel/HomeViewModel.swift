//
//  HomeViewViewModel.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
class HomeViewModel : ObservableObject {
    
    @Published var moods: [MoodItem] = []
    @Published var dueDate = Date()

    
    func addMood(forDate date: Date, mood : String) async throws {
        
        guard let uId =  Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let newUUID = UUID().uuidString
        
        let newItem = MoodItem(id: newUUID, title: mood, date: dueDate.timeIntervalSince1970)
        // Save to DB
        
        let db = Firestore.firestore()
        print("Before")

        
        do {
            try await db.collection("users").document(uId).collection("moods").document(newUUID).setData(newItem.asDictionary())
            await getMoodByDate()
        }
        catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func getMoodByDate() async {
        let db = Firestore.firestore()
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        db.collection("users").document(userId).collection("moods").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting mood items: \(error)")
                return
            }
            
            self.moods = querySnapshot?.documents.compactMap { document in
                try? document.data(as: MoodItem.self)
            } ?? []
            print(self.moods)
        }}

    
}
