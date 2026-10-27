cask "snappy@beta" do
  version "1.5.0-beta.1"
  sha256 "7da153beedc60eca5f4798e39a4c953889ec5a906077d3343d1b4f808365a0c3"

  url "https://github.com/tefa-m/snappy/releases/download/v#{version}/Snappy-#{version}.zip"
  name "Snappy Beta"
  desc "Offline screenshot, OCR, annotation, pin and screen recording tool"
  homepage "https://github.com/tefa-m/snappy"

  # Pre-releases included, drafts skipped: tags like v1.5.0-beta.2 or v1.5.0.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-beta\.\d+)?)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  conflicts_with cask: "snappy"
  depends_on macos: :tahoe

  app "Snappy.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Snappy.app"]
  end

  zap trash: [
    "~/Library/Caches/com.tefa.snappy",
    "~/Library/Preferences/com.tefa.snappy.plist",
  ]
end
