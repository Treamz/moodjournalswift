//
//  CalendarViewModel.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class CalendarViewModel : ObservableObject {
    
    @Published var moods = [MoodItem]()
       
    private var db = Firestore.firestore()
    
    func fetchMoods() {
            guard let userId = Auth.auth().currentUser?.uid else {return}
            let calendar = Calendar.current
            let currentDate = Date()

            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
            let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
               
            let startTimestamp = startOfMonth.timeIntervalSince1970
            let endTimestamp = endOfMonth.timeIntervalSince1970
            
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
                    }
                }
        }
}
