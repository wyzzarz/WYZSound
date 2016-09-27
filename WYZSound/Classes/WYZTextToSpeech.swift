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
 
  // MARK: - Pitch
  
  public enum PitchMultiplier: Float {
    case min, max, dflt
    public func floatValue() -> Float {
      switch self {
      case .min: return Float(0.5)
      case .max: return Float(2.0)
      default: return Float(1.0)
      }
    }
  }
  private var _pitchMultiplier: Float = PitchMultiplier.dflt.floatValue()
  public var pitchMultiplier: Float {
    get {
      return _pitchMultiplier
    }
    set {
      if (newValue < PitchMultiplier.min.floatValue()) {
        _pitchMultiplier = PitchMultiplier.min.floatValue()
      } else if (newValue > PitchMultiplier.max.floatValue()) {
        _pitchMultiplier = PitchMultiplier.max.floatValue()
      } else {
        _pitchMultiplier = newValue
      }
    }
  }
  
  // MARK: - Rate
  
  public enum Rate: Float {
    case min, max, dflt
    public func floatValue() -> Float {
      switch self {
      case .min: return AVSpeechUtteranceMinimumSpeechRate
      case .max: return AVSpeechUtteranceMaximumSpeechRate
      default: return AVSpeechUtteranceDefaultSpeechRate
      }
    }
  }
  private var _rate: Float = Rate.dflt.floatValue()
  public var rate: Float {
    get {
      return _rate
    }
    set {
      if (newValue < Rate.min.floatValue()) {
        _rate = Rate.min.floatValue()
      } else if (newValue > Rate.max.floatValue()) {
        _rate = Rate.max.floatValue()
      } else {
        _rate = newValue
      }
    }
  }
  
  // MARK: - Volume
  
  public enum Volume: Float {
    case min, max, dflt
    public func floatValue() -> Float {
      switch self {
      case .min: return 0
      case .max: return 1
      default: return 1
      }
    }
  }
  private var _volume: Float = Volume.dflt.floatValue()
  public var volume: Float {
    get {
      return _rate
    }
    set {
      if (newValue < Volume.min.floatValue()) {
        _volume = Volume.min.floatValue()
      } else if (newValue > Volume.max.floatValue()) {
        _volume = Volume.max.floatValue()
      } else {
        _volume = newValue
      }
    }
  }
  
  // MARK: - Methods
  
  public init() {
    pitchMultiplier = PitchMultiplier.dflt.floatValue()
    rate = Rate.dflt.floatValue()
    volume = Volume.dflt.floatValue()
  }
  
  public func speak(text: String?) -> AVSpeechUtterance {
    let utt = AVSpeechUtterance(string: text ?? "")
    utt.pitchMultiplier = pitchMultiplier
    utt.rate = rate
    utt.volume = volume
    synthesizer.speakUtterance(utt)
    return utt
  }

  /*
   * Requires the following in Info.plist:
   * Requred background modes: App plays audio or streams audio/video using AirPlay
   */
  private var _backgroundEnabled = false;
  public var backgroundEnabled: Bool {
    get { return _backgroundEnabled }
    set {
      _backgroundEnabled = newValue
      do {
        let sess = AVAudioSession.sharedInstance()
        if _backgroundEnabled { try sess.setCategory(AVAudioSessionCategoryPlayback) }
        try sess.setActive(newValue)
      } catch { }
    }
  }
  
}
