cask "snappy" do
  version "1.4.0"
  sha256 "13c304e6e1e85463b35929fa7aef5008bd5c25e6deb16306545cca162f7bf6ac"

  url "https://github.com/tefa-m/snappy/releases/download/v#{version}/Snappy-#{version}.zip"
  name "Snappy"
  desc "Offline screenshot, OCR, annotation, pin and screen recording tool"
  homepage "https://github.com/tefa-m/snappy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"

  app "Snappy.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Snappy.app"]
  end

  zap trash: [
    "~/Library/Caches/com.tefa.snappy",
    "~/Library/Preferences/com.tefa.snappy.plist",
  ]
end
