Pod::Spec.new do |spec|
  spec.name = 'GenericTableCell'
  spec.summary = 'A UITableViewCell subclass that allows you to embed any UIView into a UITableViewCell… generically'
  spec.version = '1.0'
  spec.license = { :type => 'MIT' }
  spec.authors =  { 'Joe Fabisevich' => 'github@fabisevi.ch' }
  spec.source_files = 'src/*.{swift}'
  spec.homepage = 'https://github.com/mergesort/GenericTableCell'
  spec.source  = { :git => 'https://github.com/mergesort/GenericTableCell.git' }

  spec.ios.deployment_target = '9.0'
  spec.requires_arc = true
  spec.social_media_url = 'https://twitter.com/mergesort'
  spec.framework = 'UIKit'
end