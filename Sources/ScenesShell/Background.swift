import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
      }

      override func render(canvas: Canvas) {
          canvas.render(Rectangle(rect: Rect(size: canvas.canvasSize!), fillMode: .clear))
      }
}
