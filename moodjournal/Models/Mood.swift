//
//  Moof.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 04.06.2024.
//

import Foundation


struct Mood: Hashable {
    let emoji: String
    let name: String
    
}

let moods = [
    Mood(emoji: "camera", name: "camera"),
    Mood(emoji: "😡", name: "angry"),
    Mood(emoji: "😠", name: "annoyed"),
    Mood(emoji: "😤", name: "frustrated"),
    Mood(emoji: "😊", name: "happy"),
    Mood(emoji: "😢", name: "sad"),
    Mood(emoji: "😭", name: "crying"),
    Mood(emoji: "😔", name: "pensive"),
    Mood(emoji: "😞", name: "disappointed"),
    Mood(emoji: "😒", name: "unamused"),
    Mood(emoji: "😕", name: "confused"),
    Mood(emoji: "😟", name: "worried"),
    Mood(emoji: "😨", name: "fearful"),
    Mood(emoji: "😰", name: "anxious"),
    Mood(emoji: "😩", name: "weary"),
    Mood(emoji: "😫", name: "tired"),
    Mood(emoji: "😴", name: "sleepy"),
    Mood(emoji: "😐", name: "neutral"),
    Mood(emoji: "😶", name: "speechless"),
    Mood(emoji: "🤔", name: "thinking"),
    Mood(emoji: "😏", name: "smirking"),
    Mood(emoji: "🙂", name: "slightly happy"),
    Mood(emoji: "😄", name: "smiling"),
    Mood(emoji: "😁", name: "grinning"),
    Mood(emoji: "😆", name: "laughing"),
    Mood(emoji: "🤣", name: "rolling on the floor"),
    Mood(emoji: "😍", name: "in love"),
    Mood(emoji: "🥰", name: "loved"),
    Mood(emoji: "😎", name: "cool"),
    Mood(emoji: "🤩", name: "star-struck"),
    Mood(emoji: "😌", name: "relieved"),
    Mood(emoji: "😮", name: "surprised"),
    Mood(emoji: "🤯", name: "mind-blown"),
    Mood(emoji: "🥳", name: "partying"),
    Mood(emoji: "😇", name: "innocent"),
    Mood(emoji: "🤗", name: "hugging"),
    Mood(emoji: "🥺", name: "pleading"),
    Mood(emoji: "😶‍🌫️", name: "in a fog"),
    Mood(emoji: "🤥", name: "lying"),
    Mood(emoji: "🙄", name: "eye rolling"),
    Mood(emoji: "😬", name: "grimacing"),
    Mood(emoji: "🥴", name: "woozy"),
    Mood(emoji: "🤒", name: "sick"),
    Mood(emoji: "🤕", name: "hurt"),
    Mood(emoji: "🥵", name: "hot"),
    Mood(emoji: "🥶", name: "cold"),
    Mood(emoji: "🤢", name: "nauseated"),
    Mood(emoji: "😈", name: "devious"),
    Mood(emoji: "😑", name: "expressionless"),
    Mood(emoji: "🤪", name: "zany"),
    Mood(emoji: "🥲", name: "smiling with tears"),
    Mood(emoji: "😃", name: "very happy")
]
