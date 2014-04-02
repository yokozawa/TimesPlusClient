default:
	xcodebuild -workspace TimesPlusClient.xcworkspace -scheme TimesPlusClient -configuration Release build -sdk iphoneos

adhoc:
	if [ -a build]; then rm -R build; fi;
	xcodebuild -sdk iphoneos -workspace TimesPlusClient.xcworkspace -scheme TimesPlusClient -configuration Release clean build CONFIGURATION_BUILD_DIR=$(PWD)/build PROVISIONING_PROFILE=41EEEB8D-BB6B-450F-9D95-CB36522F4BCC
	xcrun -sdk iphoneos PackageApplication build/Release-iphoneos/TimesPlusClient.app -o $(PWD)/build/TimesPlusClient.ipa --embed tpcadhoc.mobileprovision
	dgate push yokozawa build/TimesPlusClient.ipa