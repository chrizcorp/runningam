# runningam

An open-source interval training app, because I found no good alternative. ¯\_(ツ)_/¯

## preamble 

It's my first Flutter app, so there is no guarantee that I follow best practices or good design patterns, 
and separate widgets good enough. But I'm open to suggestions that improve things and teach me something.

## Getting Started

#### requirements
* flutter
* npm
* android sdk emulation API 29 or greater

#### generate model classes
* **dart run build_runner build:** ```npm run dart run build_runner build```

#### project run
* **Dart entry point:** ./lib/main.dart

#### build apk
1. execute ``flutter build apk --split-per-abi``
2. find your apk under
   > build/app/outputs/flutter-apk/

## ToDos
- fix the bug which doesn't add interval to a training set in the UI
- add documentation
- add tests
- add GPS tracking

## LICENSE
The code in this repository is covered by different licenses depending on your usage.
For non-commercial use, it is available under the GNU AGPL license V3.
For commercial use or usage in a closed source project please contact [contact@chrizcorp.com](mailto:contact@chrizcorp.com?subject=[GitHub]%20Runningham%20individual%20license) for an individual arrangement. 
