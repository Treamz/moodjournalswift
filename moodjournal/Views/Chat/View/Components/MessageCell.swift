import SwiftUI

struct MessageCell: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(LocalizedStringKey(contentMessage))
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color(.systemGray6 ))
            .cornerRadius(10)
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 10))

    }
}

#Preview {
    MessageCell(contentMessage: "This is a single message cell.", isCurrentUser: false)
}
