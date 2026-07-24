# Homebrew Cask for Toki.
#
# This file belongs in a tap repo (aashutoshrathi/homebrew-tap) under Casks/toki.rb.
# scripts/update-cask.sh regenerates the version + sha256 after each release.
cask "toki" do
  version "2.4.3"
  # update-cask.sh replaces this after each release
  sha256 "3044e411d77e98300ae5ee8d6bf8913884df5782e13ed0785d5c3cc0e95f35db"

  url "https://github.com/aashutoshrathi/toki/releases/download/v#{version}/Toki_#{version}_universal.dmg"
  name "Toki"
  desc "Menu bar companion for AI coding agents and usage"
  homepage "https://github.com/aashutoshrathi/toki"

  depends_on macos: :sonoma

  app "Toki.app"

  # The release DMG is ad-hoc signed and not notarized, so Gatekeeper quarantines it.
  # Strip the quarantine flag on install so the app opens without a right-click-Open.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Toki.app"],
                   sudo: false
  end

  zap trash: [
    "~/.tokenbar",
    "~/.toki",
  ]

  caveats <<~EOS
    Toki is ad-hoc signed and not notarized. If macOS still blocks it, open it once with:
      Right-click Toki in Applications > Open
    or clear quarantine manually:
      xattr -dr com.apple.quarantine /Applications/Toki.app
  EOS
end
