require File.dirname(__FILE__) + '/../../spec_helper'

describe AttachmentFu::Pixels::CoreImage do
  before :all do
    FileUtils.mkdir_p AttachmentFu.root_path
    @samples = File.join(File.dirname(__FILE__), 'samples')
    @pixels  = AttachmentFu::Pixels.new :core_image
  end
    
  after :all do
    FileUtils.rm_rf AttachmentFu.root_path
  end
  
  describe "(for JPG)" do
    before do
      @pixels.file = File.join(@samples, 'casshern.jpg')
    end

    it "gets accurate dimensions" do
      @pixels.with_image do |image|
        image.extent.size.width.should  == 80
        image.extent.size.height.should == 75
      end
    end
    
    it "resizes image" do
      @pixels.with_image do |image|
        data = @pixels.resize_image image, :size => '40x40', :to => File.join(AttachmentFu.root_path, 'resized.jpg')
        data.width.should  == 40
        data.height.should == 38
        data.size.should   == 2339
      end
    end
  end
end