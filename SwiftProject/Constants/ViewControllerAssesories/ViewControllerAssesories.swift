//
//  ViewControllerAssesories.swift
//  SwiftProject
//
//  Created by Admin on 02/04/24.
//

import Foundation
import UIKit

//MARK: StoryBoard List............................
class StoryBoard{
    static var mainStoryBoard: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
}


//MARK: ViewController List............................
class ViewControllerAssesories{
    static var tabbarVC: TabBarVC{
        if let viewController = StoryBoard.mainStoryBoard.instantiateViewController(identifier: "TabBarVC") as? TabBarVC{
            return viewController
        }else{
            return TabBarVC()
        }
    }
    
    static var forYouVC: ForYouVC{
        if let viewController = StoryBoard.mainStoryBoard.instantiateViewController(identifier: "ForYouVC") as? ForYouVC{
            return viewController
        }else{
            return ForYouVC()
        }
    }
    
    static var topTracksVC: TopTracksVC{
        if let viewController = StoryBoard.mainStoryBoard.instantiateViewController(identifier: "TopTracksVC") as? TopTracksVC{
            return viewController
        }else{
            return TopTracksVC()
        }
    }
    
    static var songVC: SongVC{
        if let viewController = StoryBoard.mainStoryBoard.instantiateViewController(identifier: "SongVC") as? SongVC{
            return viewController
        }else{
            return SongVC()
        }
    }
}
