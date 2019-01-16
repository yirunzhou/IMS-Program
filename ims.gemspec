# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "ims"
  spec.version       = '1.0'
  spec.authors       = ["Yirun Zhou"]
  spec.email         = ["yirunzhou@brandeis.edu"]
  spec.summary       = %q{assignment1 for 105b}
  spec.description   = %q{assignment1 for 105b, IMS program}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = ['lib/ims.rb']
  spec.executables   = ['bin/imsE']
  spec.test_files    = ['tests/test_ims.rb']
  spec.require_paths = ["lib"]
end
