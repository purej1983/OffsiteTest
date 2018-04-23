# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OffsiteTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  platform :ios, '9.0'

  # Pods for OffsiteTest

  pod 'RxAlamofire', '~> 4.2'
  pod 'Kingfisher', '~> 4.0'
  pod 'Cosmos', '~> 15.0'
  pod 'SnapKit', '~> 4.0.0'
  pod 'RxCocoa', '~> 4.1'
  pod 'ReachabilitySwift'
  
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end

  target 'OffsiteTestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OffsiteTestUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
