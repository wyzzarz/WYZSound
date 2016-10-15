//
//  WYZTimeToSpeech.swift
//  WYZSound
//
//  Copyright 2016 Warner Zee. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import AVFoundation
import Foundation

open class WYZTimeToSpeech : WYZTextToSpeech {
  
  open let dateFormatter = DateFormatter()
  static open let dateToken = "📅"
  var _dateMessage: String?
  open var dateMessage: String? {
    get { return _dateMessage ?? "Today is \(WYZTimeToSpeech.dateToken)" }
    set { _dateMessage = newValue }
  }
  
  open let timeFormatter = DateFormatter()
  static open let timeToken = "⏰"
  var _timeMessage: String?
  open var timeMessage: String? {
    get { return _timeMessage ?? "The time is now \(WYZTimeToSpeech.timeToken)" }
    set { _timeMessage = newValue }
  }

  var _dateTimeMessage: String?
  open var dateTimeMessage: String? {
    get { return _dateTimeMessage ?? "It is \(WYZTimeToSpeech.timeToken) on \(WYZTimeToSpeech.dateToken)" }
    set { _dateTimeMessage = newValue }
  }
  
  override public init() {
    super.init()
    dateFormatter.dateStyle = DateFormatter.Style.short
    timeFormatter.timeStyle = DateFormatter.Style.short
  }
  
  // MARK: - DATE
  
  open func speakDate() -> AVSpeechUtterance {
    return speakDate(Date())
  }
  
  open func speakDate(_ date: Date) -> AVSpeechUtterance {
    var fullText = dateMessage ?? WYZTimeToSpeech.dateToken
    fullText = fullText.replacingOccurrences(of: WYZTimeToSpeech.dateToken, with: dateFormatter.string(from: date))
    return speak(fullText)
  }

  // MARK: - TIME
  
  open func speakTime() -> AVSpeechUtterance {
    return speakTime(Date())
  }
  
  open func speakTime(_ date: Date) -> AVSpeechUtterance {
    var fullText = timeMessage ?? WYZTimeToSpeech.timeToken
    fullText = fullText.replacingOccurrences(of: WYZTimeToSpeech.timeToken, with: timeFormatter.string(from: date))
    return speak(fullText)
  }

  // MARK: - DATE & Time
  
  open func speakDateTime() -> AVSpeechUtterance {
    return speakDateTime(Date())
  }
  
  open func speakDateTime(_ date: Date) -> AVSpeechUtterance {
    var fullText = dateTimeMessage ?? WYZTimeToSpeech.timeToken + " on " + WYZTimeToSpeech.dateToken
    fullText = fullText.replacingOccurrences(of: WYZTimeToSpeech.dateToken, with: dateFormatter.string(from: date))
    fullText = fullText.replacingOccurrences(of: WYZTimeToSpeech.timeToken, with: timeFormatter.string(from: date))
    return speak(fullText)
  }

}
