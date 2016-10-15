//
//  WYZTextToSpeech.swift
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

open class WYZTextToSpeech {
  
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
  fileprivate var _pitchMultiplier: Float = PitchMultiplier.dflt.floatValue()
  open var pitchMultiplier: Float {
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
  fileprivate var _rate: Float = Rate.dflt.floatValue()
  open var rate: Float {
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
  fileprivate var _volume: Float = Volume.dflt.floatValue()
  open var volume: Float {
    get {
      return _volume
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
  
  open func speak(_ text: String?) -> AVSpeechUtterance {
    let utt = AVSpeechUtterance(string: text ?? "")
    utt.pitchMultiplier = pitchMultiplier
    utt.rate = rate
    utt.volume = volume
    synthesizer.speak(utt)
    return utt
  }

  /*
   * Requires the following in Info.plist:
   * Requred background modes: App plays audio or streams audio/video using AirPlay
   */
  fileprivate var _backgroundEnabled = false;
  open var backgroundEnabled: Bool {
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
