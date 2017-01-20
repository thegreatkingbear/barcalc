# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BarCalc' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BarCalc
  pod 'DDMathParser', :git => 'https://github.com/davedelong/DDMathParser.git', :tag => '3.0.0'

  target 'BarCalcTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BarCalcUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
