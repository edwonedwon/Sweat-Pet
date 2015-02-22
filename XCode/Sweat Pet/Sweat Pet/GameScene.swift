import Foundation
import SpriteKit

class GameScene : SKScene {
    
    let pet = SKSpriteNode(imageNamed: "pet")
    
    override func didMoveToView(view: SKView) {
        // 2
        backgroundColor = UIColor(red: 0.58, green: 0.84, blue: 0.78, alpha: 1)
        // 3
        pet.position = CGPoint(x: size.width * 0.5, y: size.height * 0.40)
        pet.size = CGSize(width: 387 * 0.6, height: 384 * 0.6)
        
        // 4
        addChild(pet)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, -2)
        pet.physicsBody = SKPhysicsBody(circleOfRadius: pet.size.height)
        pet.physicsBody?.dynamic = true
        
//        runAction(SKAction.repeatActionForever(
//            SKAction.sequence([
//                SKAction.runBlock(bounce),
//                SKAction.waitForDuration(2.0)
//                ])
//            ))
        
    }
    
    
    func switchImage () {
        println("switch image")
    }
    
    func bounce() {
        
        let bounceHeight = CGFloat(30.0)
        let bounceDuration = NSTimeInterval(0.3)
        let actionBounce = SKAction.moveBy(CGVector(dx: 0, dy: bounceHeight), duration: bounceDuration)
        actionBounce.timingMode = SKActionTimingMode.EaseInEaseOut
        let actionBounceReturn = SKAction.moveBy(CGVector(dx: 0, dy: -bounceHeight), duration: bounceDuration)
        actionBounceReturn.timingMode = SKActionTimingMode.EaseInEaseOut

        pet.runAction(SKAction.sequence([
            actionBounce,
            SKAction.waitForDuration(0.2),
            actionBounceReturn
            ]))
    }

}
