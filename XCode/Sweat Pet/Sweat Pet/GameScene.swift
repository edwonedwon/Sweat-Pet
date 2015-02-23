import Foundation
import SpriteKit

class GameScene : SKScene {
    
    var pet = SKSpriteNode()
    var petTargetLocation = CGVector(dx: 0, dy: 0)
    var touchLocation = CGVector()
    
    let spring = CGFloat(0.15)
    let damp = CGFloat(0.8                                                                  )
    var velocity = CGVector(dx: 0, dy: 0)
    var touching = false
    
    let textureAtlas = SKTextureAtlas(named: "petanim.atlas")
    var spriteArray = Array<SKTexture>()
    
    override func didMoveToView(view: SKView) {
        // 2
        backgroundColor = UIColor(red: 0.58, green: 0.84, blue: 0.78, alpha: 1)
        // 3
        pet.position = CGPoint(x: size.width * 0.5, y: size.height * 0.40)
        pet.size = CGSize(width: 387 * 0.6, height: 384 * 0.6)
//        pet.userInteractionEnabled = true; // this is weird, need to research
        pet.name = "pet"
        petTargetLocation = CGVector(dx: pet.position.x, dy: pet.position.y)
        // 4
        addChild(pet)
        
        spriteArray.append(textureAtlas.textureNamed("pet_1"))
        spriteArray.append(textureAtlas.textureNamed("pet_2"))
        spriteArray.append(textureAtlas.textureNamed("pet_3"))
        spriteArray.append(textureAtlas.textureNamed("pet_4"))
        pet.texture = spriteArray[1]
        
//        self.physicsWorld.gravity = CGVectorMake(0.0, -2)
//        pet.physicsBody = SKPhysicsBody(circleOfRadius: pet.size.height)
//        pet.physicsBody?.dynamic = true
        
//        runAction(SKAction.repeatActionForever(
//            SKAction.sequence([
//                SKAction.runBlock(bounce),
//                SKAction.waitForDuration(2.0)
//                ])
//            ))
        
    }
    
    override func update(currentTime: NSTimeInterval) {

    }
    
//    func clamp (number: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
//        if (number < min) {
//            return min
//        }
//        if (number > max) {
//            return max
//        }
//        return number
//    }
    
    override func didSimulatePhysics() {
        if (touching == false) {
            var dif  = CGVector(
                dx: pet.position.x - petTargetLocation.dx,
                dy: pet.position.y - petTargetLocation.dy
            )
            velocity.dx -= dif.dx * spring
            velocity.dy -= dif.dy * spring

            velocity.dx *= damp
            velocity.dy *= damp
     
            // apply velocity
            pet.position.x += velocity.dx
            pet.position.y += velocity.dy
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            touching = true
            let location = (touch as! UITouch).locationInNode(self)
            pet.position.x = location.x
            pet.position.y = location.y
            if (self.nodeAtPoint(location).name == "pet") // if touched pet
            {
                pet.texture = spriteArray[1]
            }
        }
    }

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            touching = true
            let location = (touch as! UITouch).locationInNode(self)
//            if (self.nodeAtPoint(location).name == "pet") // if touching pet
//            {
                pet.position.x = location.x
                pet.position.y = location.y
//            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        touching = false
    }
    
    func switchImage () {
//        pet.texture = spriteArray[1]
    }
    
    func bounce() {
        
        let bounceHeight = CGFloat(30.0)
        let bounceDuration = NSTimeInterval(0.1)
        let actionBounce = SKAction.moveBy(CGVector(dx: 0, dy: bounceHeight), duration: bounceDuration)
        actionBounce.timingMode = SKActionTimingMode.EaseOut
        let actionBounceReturn = SKAction.moveBy(CGVector(dx: 0, dy: -bounceHeight), duration: bounceDuration)
        actionBounceReturn.timingMode = SKActionTimingMode.EaseIn

        pet.runAction(SKAction.sequence([
            actionBounce,
            SKAction.waitForDuration(0.1),
            actionBounceReturn
            ]))
    }

}
