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
    
    @Published var moods = [MoodItem]()

    @Published var dueDate = Date()
    private var db = Firestore.firestore()

    
    func addMood(forDate date: Date, mood : String) async throws {
        
        guard let uId =  Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let newUUID = UUID().uuidString
        
        let newItem = MoodItem(id: newUUID, title: mood, date: date.timeIntervalSince1970, note: "")
        // Save to DB
        
        let db = Firestore.firestore()
        print("Before")

        
        do {
            try await db.collection("users").document(uId).collection("moods").document(newUUID).setData(newItem.asDictionary())
            await getMoodByDate(byDate: date)
        }
        catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    
    @MainActor
    func getMoodByDate(byDate date: Date) async {
        guard let userId = Auth.auth().currentUser?.uid else {return}
//        let calendar = /*Calendar*/.current
        dueDate = date
        let currentDate = date
        
        let startOfDay = currentDate.startOfDay
        let endOfDay = currentDate.endOfDay
        
        print("Date \(currentDate)")
        print("Start of date \(startOfDay)")
        print("End of date \(endOfDay)")
        let startTimestamp = startOfDay.timeIntervalSince1970
        let endTimestamp = endOfDay.timeIntervalSince1970
        
        db.collection("users").document(userId).collection("moods")
            .whereField("date", isGreaterThanOrEqualTo: startTimestamp)
            .whereField("date", isLessThanOrEqualTo: endTimestamp)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.moods = querySnapshot?.documents.compactMap { document in
                        try? document.data(as: MoodItem.self)
                    } ?? []
                    print(self.moods)
                }
            }
    }
    
    
    func deleteMood(mood: MoodItem) async {
        guard let userId = Auth.auth().currentUser?.uid else {return}

        do {
            try await db.collection("users").document(userId).collection("moods").document(mood.id).delete()
            await getMoodByDate(byDate: dueDate)
        }
        catch {
            print("DEBUG: Error delete mood")
        }
    }
}
