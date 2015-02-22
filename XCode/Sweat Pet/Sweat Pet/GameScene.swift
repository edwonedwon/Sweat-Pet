import Foundation
import SpriteKit

class GameScene : SKScene {
    
    let player = SKSpriteNode(imageNamed: "bicycle")
    
    override func didMoveToView(view: SKView) {
        // 2
        backgroundColor = SKColor.blackColor()
        // 3
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        // 4
        addChild(player)
        
    }

}
