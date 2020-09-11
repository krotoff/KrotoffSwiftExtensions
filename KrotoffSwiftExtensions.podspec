Pod::Spec.new do |s|
  s.name             = 'KrotoffSwiftExtensions'
  s.version          = '0.1.0'
  s.summary          = 'My Swift Extensions. UI, Foundation, CoreData and etc.'
 
  s.description      = 'Simple extensions for every day usage in your code. Make your code cleaner.'
 
  s.homepage         = 'https://github.com/krotoff/KrotoffSwiftExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Krotov' => 'akrotoff95@gmail.com' }
  s.source           = { :git => 'https://github.com/krotoff/KrotoffSwiftExtensions.git', :branch => 'master', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.source_files = '*'
 
end