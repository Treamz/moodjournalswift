//
//  SettingsView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI


enum SchemeType: Int, Identifiable, CaseIterable {
    var id: Self { self }
    case system
    case light
    case dark
}

extension SchemeType {
    var title: String {
        switch self {
        case .system:
            return "📱 System"
        case .light:
            return "🌝 Light"
        case .dark:
            return "🌚 Dark"
        }
    }
}

struct SettingsView: View {
    
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue

    @Environment(\.colorScheme) private var colorScheme;
    
    
    var selectedScheme: ColorScheme? {
           guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
           switch theme {
           case .light:
               return .light
           case .dark:
               return .dark
           default:
               return nil
               
           }
       }
       
    @State private var darkMode = false;
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
//                Section("Header") {
//                    
//                }
//                
                Section() {
                    Picker(selection: $systemTheme) {
                                      ForEach(SchemeType.allCases) { item in
                                          Text(item.title)
                                              .tag(item.rawValue)
                                      }
                                  } label: {
                                      Text("Pick a theme")
                                  }
                   
//                    AppleIdAuth()
                }
            }
            Text("Version \(UIApplication.version)")
        }
        .preferredColorScheme(selectedScheme)

    }
}

#Preview {
    SettingsView()
}
