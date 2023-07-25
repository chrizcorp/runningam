# runningham

An open source interval training app, because i found no good alternative. ¯\_(ツ)_/¯

## preamble 

It's my first flutter app, so there is no guarantee that I follow best practices or good design pattern, 
separate widgets good enough. But I'm open for suggestions which makes things better and teach me things.

## Getting Started

#### requirements
* flutter
* npm
* android sdk emulation API 29 or greater

#### generate model classes
* **dart run build_runner build:** ```npm run dart run build_runner build```

#### project run
* **Dart entrypoint:** ./lib/main.dart

#### build apk
1. execute ``flutter build apk --split-per-abi``
2. find your apk under
   > build/app/outputs/flutter-apk/

## ToDos
- fix bug which don't add interval to a training set in the ui
- add documentation
- add tests
- add gps tracking

## LICENSE
The code in this repository is covered by different licenses depending on your usage.
For non-commercial use it is available under the GNU AGPL license V3.
For commercial use or usage in a closed source project please contact [contact@chrizcorp.com](mailto:contact@chrizcorp.com?subject=[GitHub]%20Runningham%20individual%20license) for an individual arrangement. 