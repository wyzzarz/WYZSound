//
//  WYZTimeToSpeech.swift
//  WYZSound
//
//  Copyright (c) 2016 Warner Zee
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
