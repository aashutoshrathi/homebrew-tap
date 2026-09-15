# Homebrew Cask for Toki.
#
# This file belongs in a tap repo (aashutoshrathi/homebrew-tap) under Casks/toki.rb.
# scripts/update-cask.sh regenerates the version + sha256 after each release.
cask "toki" do
  version "3.3.5"
  # update-cask.sh replaces this after each release
  sha256 "550a6b9a7dc4c791d2dd59c5cc9c01d1856f852cede5bcfa47287156fdcdaef4"

  url "https://github.com/aashutoshrathi/toki/releases/download/v#{version}/Toki_#{version}_universal.dmg"
  name "Toki"
  desc "Menu bar companion for AI coding agents and usage"
  homepage "https://github.com/aashutoshrathi/toki"

  depends_on macos: :sonoma

  app "Toki.app"

  # Homebrew checks the incoming cask's declarations, so both sides must declare the
  # conflict for the mutual exclusion to hold in both install directions.
  conflicts_with cask: "toki-beta"

  # The release DMG is ad-hoc signed and not notarized, so Gatekeeper quarantines it.
  # Strip the quarantine flag on install so the app opens without a right-click-Open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Toki.app"]
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
