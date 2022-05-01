import Scenes

/*
 This class is responsible for the background Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class BackgroundLayer : Layer {
    let background = Background()

    let backgroundPieces = [
      BackgroundPiece(.redX),
      BackgroundPiece(.blueX),
      BackgroundPiece(.yellowX),
      BackgroundPiece(.greenX),
      BackgroundPiece(.redCircle),
      BackgroundPiece(.blueCircle),
      BackgroundPiece(.yellowCircle),
      BackgroundPiece(.greenCircle),
      BackgroundPiece(.blueCircle)
    ]

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")

        // We insert our RenderableEntities in the constructor
        insert(entity:background, at: .back)

        backgroundPieces.forEach {
            insert(entity: $0, at: .front)
        }
    }

    // Returns a list of all background pieces except the one specified
    // We need to exclude the piece specified otherwise it would be eternally
    // bouncing off of itself
    func others(except piece: BackgroundPiece) -> [BackgroundPieces] {
        
    }
}
