class Vgo < Formula
  desc "Versioned Go Prototype (vgo)"
  homepage "https://research.swtch.com/vgo"
  url "https://github.com/golang/vgo.git",
      :revision => "0e334a3ef515a6699928fee512600b826c8ee9c3"
  version "2018-02-20.1"
  revision 1
  head "https://github.com/golang/vgo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b974c08cfb94c31a652908312620e6dac1a617ffd2d21816c5e9c8f259ea559" => :high_sierra
    sha256 "4e6e39bb9678fd4ddf200a80ba657f09d3d91bd133f5795775153a3aa12688eb" => :sierra
    sha256 "4e95ecf37819ce91f1e52a6b11e6c875c2e9b3b17edba1b919c55ffc98ba95cf" => :el_capitan
  end

  depends_on "go"

  def install
    ENV["GOPATH"] = buildpath
    arch = MacOS.prefer_64_bit? ? "amd64" : "386"
    (buildpath/"src/github.com/golang/vgo").install buildpath.children
    
    cd "src/github.com/golang/vgo" do
      ENV["DEP_BUILD_PLATFORMS"] = "darwin"
      ENV["DEP_BUILD_ARCHS"] = arch
      system "go build -o vgo"
      bin.install "vgo" => "vgo"
      prefix.install_metafiles
    end
  end
end
