

Pod::Spec.new do |spec|


  spec.name         = "XTPublicTools"
  spec.version      = "0.0.1"
  spec.summary      = "XTPublicTools"
  spec.description  = "XTPublicTools description"
  spec.homepage     = "https://github.com/wangch6688/XTPublicToolsProject.git"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "Kevin" => "wangch6688@hotmail.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/wangch6688/XTPublicToolsProject.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes/**/*"
  spec.requires_arc = true
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency 'UMCCommon'
  spec.dependency 'UMCShare/UI'
  spec.dependency 'UMCShare/Social/ReducedWeChat'
  spec.dependency 'UMCShare/Social/QQ'
  spec.dependency 'UMCShare/Social/Sina'
  spec.dependency 'SDWebImage'
  spec.dependency 'Reachability'
  spec.dependency 'Masonry'
  spec.dependency 'ReactiveObjC'
  

end
