//
//  WYZTextToSpeech.swift
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

public class WYZTextToSpeech {
  
  let synthesizer = AVSpeechSynthesizer()
  
  public enum PitchMultiplier: Float {
    case min, max, dflt
    func floatValue() -> Float {
      switch self {
      case .min: return Float(0.5)
      case .max: return Float(2.0)
      default: return Float(1.0)
      }
    }
  }
  public var pitchMultiplier: Float
  
  public enum Rate: Float {
    case min, max, dflt
    func floatValue() -> Float {
      switch self {
      case .min: return AVSpeechUtteranceMinimumSpeechRate
      case .max: return AVSpeechUtteranceMaximumSpeechRate
      default: return AVSpeechUtteranceDefaultSpeechRate
      }
    }
  }
  public var rate: Float
  
  public init() {
    pitchMultiplier = PitchMultiplier.dflt.floatValue()
    rate = Rate.dflt.floatValue()
  }
  
  public func speak(text: String?) -> AVSpeechUtterance {
    let utt = AVSpeechUtterance(string: text ?? "")
    utt.pitchMultiplier = pitchMultiplier
    utt.rate = rate
    synthesizer.speakUtterance(utt)
    return utt
  }
  
}
