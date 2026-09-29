public import PDF_Standard
public import Renderer

public typealias BuilderRaw = Renderer.Document.Builder

extension PDF {

    public typealias Builder = BuilderRaw
}

extension BuilderRaw {

    public static func buildBlock() -> Renderer.Document.Empty {
        Renderer.Document.Empty()
    }
}
