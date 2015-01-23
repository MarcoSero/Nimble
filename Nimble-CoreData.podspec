Pod::Spec.new do |s|
  s.name         = "Nimble-CoreData"
  s.version      = "0.0.2"
  s.summary      = "Core Data and iCloud made nimble and fast."
  s.homepage     = "http://github.com/marcosero/Nimble"
  s.license      = 'MIT'
  s.author       = { "Marco Sero" => "marco@marcosero.com" }
  s.source       = { :git => "http://github.com/marcosero/Nimble", :tag => "0.0.2" }
  s.platform     = :ios, '6.0'
  s.source_files = 'Nimble'
  s.framework = 'CoreData'
  s.requires_arc = true
end
