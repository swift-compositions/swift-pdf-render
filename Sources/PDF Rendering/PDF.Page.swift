extension PDF.Page {

    public init(
        mediaBox: ISO.`32000`.UserSpace.Rectangle,
        contentStream: ISO.`32000`.ContentStream,
        annotations: [PDF.Annotation] = []
    ) {
        var fontResources: [ISO.`32000`.COS.Name: ISO.`32000`.Font] = [:]
        for font in contentStream.fontsUsed {
            fontResources[font.resourceName] = font
        }

        var imageResources: [ISO.`32000`.COS.Name: ISO.`32000`.Image] = [:]
        for image in contentStream.imagesUsed {
            imageResources[image.resourceName] = image
        }

        self.init(
            mediaBox: mediaBox,
            content: contentStream,
            resources: ISO.`32000`.Resources(fonts: fontResources, xObjects: imageResources),
            annotations: annotations
        )
    }
}
