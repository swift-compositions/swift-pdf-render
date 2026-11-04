# swift-pdf-render

Use this package when you lay out PDF pages in Swift as composable views: text, stacks, rectangles, dividers, spacers and tagged tables. Build a `PDF.Document` from `PDF.View` values, or render views into a `PDF.Context` yourself. A renderer for another document model can drive the same context through `Renderer.Document.Context.pdf(state:)`. If you write content as HTML views, use swift-pdf-html-render. If you want Markdown or HTML turned into PDF files, use swift-pdf.

## Laws

- `PDF.Document` renders its content when it's created. Viewer preferences are left out of the document when they equal the defaults.
- Layout runs from the top of the page down. A context's `y` is the distance from the top of the media box, and it is flipped to PDF's bottom-up coordinates only when content is emitted.
- Without other settings, text is Helvetica at 12 points in black with a line height of 1.2.
- Text is encoded as WinAnsi, with a fallback for characters WinAnsi lacks.
- `PDF.Text` wraps only at spaces. A word wider than the available width gets a line of its own and is never broken. Empty text still takes one line. Text inside a horizontal stack doesn't wrap.
- A new page starts before any line of text, divider or rectangle that would cross the bottom margin. A horizontal stack written as separate children is measured first and moves to a new page as a whole. One built from a loop is not.
- `PDF.Context.measure(_:)` lays out its content without emitting anything or completing pages, then restores the context. The height it returns includes the room lost to page breaks.
- A vertical stack adds its spacing only between children that took up height, never after the last. A horizontal stack starts every child at the same height and ends at the bottom of its tallest child, back at its starting `x`.
- Through `Renderer.Document.Context.pdf(state:)`, headings are bold at 24, 20, 16, 14, 12 and 11 points by level. Headings and paragraphs get space above them except at the top. Block quotes and lists are indented 20 points, block quotes are gray, and preformatted text is Courier with its white space kept. Elsewhere runs of white space collapse to one space and a tab is four spaces wide. Each block of text is wrapped in an ActualText span with its white space collapsed, so copying from a viewer gives back the words.
- Unordered list markers are a bullet at the first level, an open circle at the second and a filled square below that. Ordered lists count from their start number, or from 1.
- Links are blue and underlined, with a link annotation over the text. Images are not drawn. They show as their alt text in brackets, or as `[image]`, in gray italics.
- Links to an internal target are kept pending until `PDF.Context.resolveInternalLinks(pages:pendingLinks:namedDestinations:)`. A pending link whose target has no named destination is dropped.
