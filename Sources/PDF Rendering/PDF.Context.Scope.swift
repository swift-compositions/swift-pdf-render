import Layout
public import PDF_Standard

extension PDF.Context {

    public struct Scope: Sendable {
        public let style: Style.Resolved
        public let llx: PDF.UserSpace.X
        public let preserveWhitespace: Bool
        public let noWrap: Bool
        // swift-linter:disable:next raw concept
        // REASON: a link's target as the document wrote it, an HTML href or a Markdown destination that may be relative or malformed, carried unparsed to where the PDF URI action is written; looked at RFC_3986.URI, whose parsing refuses such text and would silently drop the link.
        public let linkURL: String?
    }
}
