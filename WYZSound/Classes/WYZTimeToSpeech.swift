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

public class WYZTimeToSpeech : WYZTextToSpeech {
  
  public let dateFormatter = NSDateFormatter()
  public let dateToken = "📅"
  
  public let timeFormatter = NSDateFormatter()
  public let timeToken = "⏰"
  
  public var dateMessage: String?
  public var timeMessage: String?
  public var dateTimeMessage: String?
  
  override public init() {
    super.init()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    dateMessage = "Today is " + dateToken
    timeMessage = "The time is now " + timeToken
    dateTimeMessage = "It is " + timeToken + " on " + dateToken
  }
  
  // MARK: - DATE
  
  public func speakDate() -> AVSpeechUtterance {
    return speakDate(NSDate())
  }
  
  public func speakDate(date: NSDate) -> AVSpeechUtterance {
    var fullText = dateMessage ?? dateToken
    fullText = fullText.stringByReplacingOccurrencesOfString(dateToken, withString: dateFormatter.stringFromDate(date))
    return speak(fullText)
  }

  // MARK: - TIME
  
  public func speakTime() -> AVSpeechUtterance {
    return speakTime(NSDate())
  }
  
  public func speakTime(date: NSDate) -> AVSpeechUtterance {
    var fullText = timeMessage ?? timeToken
    fullText = fullText.stringByReplacingOccurrencesOfString(timeToken, withString: timeFormatter.stringFromDate(date))
    return speak(fullText)
  }

  // MARK: - DATE & Time
  
  public func speakDateTime() -> AVSpeechUtterance {
    return speakDateTime(NSDate())
  }
  
  public func speakDateTime(date: NSDate) -> AVSpeechUtterance {
    var fullText = dateTimeMessage ?? timeToken + " on " + dateToken
    fullText = fullText.stringByReplacingOccurrencesOfString(dateToken, withString: dateFormatter.stringFromDate(date))
    fullText = fullText.stringByReplacingOccurrencesOfString(timeToken, withString: timeFormatter.stringFromDate(date))
    return speak(fullText)
  }

}
