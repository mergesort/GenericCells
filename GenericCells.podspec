Pod::Spec.new do |spec|
  spec.name = 'GenericCells'
  spec.summary = 'Taking advantage of generics instead of subclassing for UITableViewCell and UICollectionViewCell.'
  spec.version = '1.1.1'
  spec.license = { :type => 'MIT' }
  spec.authors =  { 'Joe Fabisevich' => 'github@fabisevi.ch' }
  spec.source_files = 'src/*.{swift}'
  spec.homepage = 'https://github.com/mergesort/GenericCells'
  spec.source  = { :git => 'https://github.com/mergesort/GenericCells.git', :tag => "#{spec.version}" }

  spec.ios.deployment_target = '9.0'
  spec.requires_arc = true
  spec.social_media_url = 'https://twitter.com/mergesort'
  spec.framework = 'UIKit'
end
