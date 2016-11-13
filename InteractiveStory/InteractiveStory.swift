//
//  InteractiveStory.swift
//  InteractiveStory
//
//  Created by Danny Garcia on 11/13/16.
//  Copyright © 2016 Danny Garcia. All rights reserved.
//

import Foundation
import UIKit

enum Story: String {
  case returnTrip
  case touchDown
  case homeward
  case rover
  case cave
  case crate
  case monster
  case droid
  case home
}

extension Story {
  var artwork: UIImage {
    get {
      return UIImage(named: self.rawValue)!
    }
  }
  
  var text: String {
    get {
      switch self {
      case .returnTrip:
        return "On your return trip from studying Saturn's rings, you hear a distress signal that seems to be coming from the surface of Mars. It's strange because there hasn't been a colony there in years. \"Help me, you're my only hope.\""
      case .touchDown:
        return "You deftly land your ship near where the distress signal originated. You didn't notice anything strange on your fly-by, behind you is an abandoned rover from the early 21st century and a small crate."
      case .homeward:
        return "You continue your course to Earth. Two days later, you receive a transmission from HQ saing that they have detected some sort of anomaly on the surface of Mars near an abandoned rover. They ask you to investigate, but ultimately the decision is yours because your mission has already run much longer than planned and supplies are low."
      case .rover:
        return "The rover is covered in dust and most of the solar panels are broken. But you are quite surprised to see the on-board system booted up and running. In fact, there is a message on the screen. \"Come to 28.2342, -81.08273\". These coordinates aren't far but you don't know if your oxygen will last there and back."
      case .cave:
        return "Your EVA suit is equipped with a headlamp which you use to navigate to a cave. After searching for a while your oxygen levels are starting to get pretty low. You know you should go refill your tank, but there's a faint light up ahead."
      case .crate:
        return "Unlike everything else around you the crate seems new and...alien. As you examine the create you notice something glinting on the ground beside it. Aha, a key! It must be for the crate..."
      case .monster:
        return "You pick up the key and try to unlock the crate, but the key breaks off in the keyhole.You scream out in frustration! Your scream alerts a creature that captures you and takes you away..."
      case .droid:
        return "After a long walk slightly uphill, you end up at the top of a small crater. You look around and are overjoyed to see your robot friend, Droid-S1124. It had been lost on a previous mission to Mars. You take it back to your ship and fly back to Earth."
      case .home:
        return "You arrive home on Earth. While your mission was a success, you forever wonder what was sending that signal. Perhaps a future mission will be able to investigate."
      }
    }
  }
}

class Page {
  let story: Story
  
  typealias Choice = (title: String, page: Page)
  
  var firstChoice: Choice?
  var secondChoice: Choice?
  
  init(story: Story) {
    self.story = story
  }
}

extension Page {
  
  func addChoice(title: String, story: Story) -> Page {
    let page = Page(story: story)
    return addChoice(title: title, page: page)
  }

  func addChoice(title: String, page: Page) -> Page {
    
    switch (firstChoice, secondChoice) {
    case (.some, .some): break
    case (.none, .none), (.none, .some):
      firstChoice = (title, page)
    case(.some, .none):
      secondChoice = (title, page)
    }
    
    return page
  }
}

struct Adventure {
  static var story: Page {
    let returnTrip = Page(story: .returnTrip)
    let touchDown = returnTrip.addChoice(title: "Stop and Investigate", story: .touchDown)
    let homeward = returnTrip.addChoice(title: "Continue Home to Earth", story: .homeward)
    let rover = touchDown.addChoice(title: "Explore the Rover", story: .rover)
    let crate = touchDown.addChoice(title: "Open the Crate", story: .crate)
    
    homeward.addChoice(title: "Head back to Mars", page: touchDown)
    let home = homeward.addChoice(title: "Continue Home to Earth", story: .home)
    
    let cave = rover.addChoice(title: "Explore the Coordinates", story: .cave)
    rover.addChoice(title: "Return to Earth", page: home)
    
    cave.addChoice(title: "Continue towards faint light", story: .droid)
    cave.addChoice(title: "Refill the ship and explore the rover", page: rover)
    
    crate.addChoice(title: "Explore the Rover", page: rover)
    crate.addChoice(title: "Use the key", story: .monster)
    
    return returnTrip
    
  }
}
