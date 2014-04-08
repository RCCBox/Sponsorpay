<p align="center"><img src="./Documentation/images/logo.png"></p>

---

The whole idea of this challenge is to use the SponsorPay Mobile Offers API (JSON) and render the results of the response in a native iOS application.

#### Prerequisites

* Code style is based on the [Rocket Objective-C style guide](https://github.com/rocketinternet/objective-c-style-guide)

* The project is implemented as an iOS static library because this is very likely the way you would want to go with theses kinds of "linkable" code pieces that add ad vendor functionality to you iOS app (top reasons for using a static library: code protection, enforces encapsulation, easy installation on client side)

* Every interface of the library that is not exposed to the client programmer uses an internal error handling mechanism which is super strict. Only solvable error messages ever reach the client programmer. Internal non anticipated invalid states of the software lead to immediate cancelation of whatever operation is running. This should make crashes caused by the Sponsorpay lib very unlikely.

* Testing: Only the SPAPIController class is being tested in order to keep the effort for this project in sane boundaries. Kiwi is being used as a testing framework because BDD testing allows much better structuring of the test classes and makes it easy to cover various test scenarios

#### Getting the source code

Clone the project including submodules:

	$ git clone --recursive https://github.com/robertoseidenberg/Sponsorpay.git

There are plenty of visible schemes after cloning the project. Sadly this is default behavior by XCode because scheme visibility is not being stored globally but on a per user basis. If you want to keep things tidy go to "Manage schemes" immediately after opening the project for the first time and hide all schemes except those ones prefixed with "Sponsorpay".

#### Building libSponsorpay.a:

##### Build target: Sponsorpay

Builds the static library.

#### Testing libSponsorpay.a:

Unit tests can be executed on the simulator by selecting the Sponsorpay target and selecting "Products -> Test" from the menu. 

#### Demo app

##### Build target: SponsorpayDemoApp

Wrapper iOS app for the Sponsorpay static library that is able to perform a request to the Sponsorpay offers API and displays the fetched results in a table view.

#### Acknowledgements

Unit testing:

* [Kiwi](https://github.com/allending/Kiwi)

UI:

* [EGOImageLoading](https://github.com/enormego/EGOImageLoading)