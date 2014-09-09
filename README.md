# PresentationKit

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

## Source Code

The `sourceCode` property returns the associated source code for the
demo that is being shown. This source code is generated at compile time
by the script `generate_html.sh`.

This script requires Pygments 2.0pre to be installed in the local system:

    Pygments version 2.0pre, (c) 2006-2014 by Georg Brandl.

When this project was created, the version of Pygments available
through PIP was 1.6; however, version 2.0 (including Swift support)
must be installed manually, downloading the code from the [main
Pygments repository][pygments] and running the commands

    sudo ./setup.py build
    sudo ./setup.py install


## License

See the LICENSE file for details.

[pygments]: https://bitbucket.org/birkenfeld/pygments-main/downloads

