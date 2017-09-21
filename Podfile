source 'https://github.com/CocoaPods/Specs.git'
source 'https://git.coding.net/ge3kxm/podSepc.git'

use_frameworks!
inhibit_all_warnings!

platform :ios, '8.0'

workspace 'MXUF'

target 'MXUniversalFrame' do
	project ‘MXUF/MXUniversalFrame.xcodeproj’

	pod ‘MXHomepage’, :path => ‘MXHomepage’
end

target ‘MXBase’ do
	project ‘MXBase/MXBase.xcodeproj’
	pod ‘Masonry’
end

target ‘MXHomepage’ do
	project ‘MXHomepage/MXHomepage.xcodeproj’
	pod ‘MXBase’, :path => ‘MXBase’
end