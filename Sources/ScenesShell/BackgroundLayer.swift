import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayer : Layer {
      let background = Background()

      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")

          // We insert our RenderableEntities in the constructor
          insert(entity:background, at: .back)
          
          insert(entity: BackgroundPiece(.redX), at: .front)
          insert(entity: BackgroundPiece(.blueX), at: .front)
          insert(entity: BackgroundPiece(.yellowX), at: .front)
          insert(entity: BackgroundPiece(.greenX), at: .front)
          insert(entity: BackgroundPiece(.redCircle), at: .front)
          insert(entity: BackgroundPiece(.blueCircle), at: .front)
          insert(entity: BackgroundPiece(.yellowCircle), at: .front)
          insert(entity: BackgroundPiece(.greenCircle), at: .front)
          insert(entity: BackgroundPiece(.blueCircle), at: .front)
      }
  }
