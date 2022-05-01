import Foundation
import Scenes
import Igis


class BackgroundPiece: RenderableEntity {

    let imageSize = Size(width: 250, height: 250)

    enum Piece {
        case yellowCircle
        case greenCircle
        case blueCircle
        case redCircle

        case yellowX
        case greenX
        case blueX
        case redX
    }
    
    static let urls: Dictionary<Piece, URL> = {
        let rootURL = URL(string: "https://www.codermerlin.com/users/anton-bily/images")!
        
        var urls = Dictionary<Piece, URL>()
        urls[.yellowCircle] = rootURL.appendingPathComponent("YellowCircle.png")
        urls[.greenCircle] = rootURL.appendingPathComponent("GreenCircle.png")
        urls[.blueCircle] = rootURL.appendingPathComponent("BlueCircle.png")
        urls[.redCircle] = rootURL.appendingPathComponent("RedCircle.png")
        
        urls[.yellowX] = rootURL.appendingPathComponent("YellowX.png")
        urls[.greenX] = rootURL.appendingPathComponent("GreenX.png")
        urls[.blueX] = rootURL.appendingPathComponent("BlueX.png")
        urls[.redX] = rootURL.appendingPathComponent("RedX.png")
        
        return urls
    }()


    let image: Image
    let rotationRate = Double.random(in: (-1.0  * Double.pi / 180.0) ... (1.0 * Double.pi / 180.0))
    var topLeft = Point.zero
    var currentRadians = 0.0
    
    init(_ piece: Piece) {
        image = Image(sourceURL: Self.urls[piece]!)
        super.init(name: "BackgroundPiece")
    }
    
    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(image)
        
        topLeft = Point(x: Int.random(in: 0 ..< canvasSize.width),
                        y: Int.random(in: 0 ..< canvasSize.height))
    }

    override func boundingRect() -> Rect {
        return Rect(topLeft: topLeft, size: imageSize)
    }
    
    override func calculate(canvasSize: Size) {
        image.renderMode = .destinationPoint(topLeft)
        topLeft.x += 3
        currentRadians += rotationRate
        
        let targetCenter = topLeft + Point(x: imageSize.width, y: imageSize.height)
        let preTranslate = Transform(translate:DoublePoint(targetCenter))
        let rotate = Transform(rotateRadians:currentRadians)
        let postTranslate = Transform(translate:DoublePoint(-targetCenter))
        setTransforms(transforms:[preTranslate, rotate, postTranslate])
        
        if topLeft.x > canvasSize.width {
            topLeft.x = -imageSize.width
        }

        let imageBoundingRect = boundingRect()
        let containment = pngBoundingRect.containment(target: imageBoundingRect)
        
        if !containment.intersection([.overlapsRight, .beyondRihgt, .overlapsLeft, .beyondLeft]).isempty {
            topLeft.x *= -1
        }
        
    }
    
    override func render(canvas: Canvas) {
        if image.isReady {
            canvas.render(image)
        }
    }
}
