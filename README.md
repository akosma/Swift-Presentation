# Swift Presentation

This project generates and deploys a Cocoa framework built with Swift,
which can be used from the command-line REPL or from an Xcode Playground
as follows:

    import PresentationKit

    let pres = Presentation(name: "Tao of Swift")
    let currentDemo = pres["sets"]

    if let demo = currentDemo {

        let URL = demo.URL
        let tweet = demo.tweet
        let source = demo.sourceCode

        demo.explain()
        demo.copyCode()
        demo.show()
    }

    // The Presentation class can be iterated
    for demo in pres {
        println(demo.show())
    }

Explanation of the code:

- The `explain()` method uses the OS X speech synthesizer to read the
  `description` property aloud.
- The `copyCode()` method places the source code of the current demo in
  the Pasteboard.
- The `show()` method executes the demo itself.
- The `URL` and `tweet` properties return associated NSURL instances
  that can be displayed right from the Playground itself.

## Playgrounds

The `Playgrounds` folder contains a few Swift Playgrounds for Xcode 6,
showing several different features of the language, useful for learning.

## Source Code

The `sourceCode` property returns the associated source code for the
demo that is being shown. This source code is generated at compile time
by the script `generate_html.sh`.

This script requires Pygments 2.0 or later to be installed in the local
system; use the `sudo easy_install Pygments` command for that.

## License

See the LICENSE file for details.

