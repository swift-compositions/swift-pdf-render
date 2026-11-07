public import PDF_Standard
public import Renderer

extension Renderer.Document.Empty: PDF.View {
    public typealias Content = Never

    public static func _render(_ markup: Renderer.Document.Empty, context: inout PDF.Context) {

    }

    public var body: Never { fatalError("Empty uses direct rendering") }
}
