# Homebrew Cask for Toki.
#
# This file belongs in a tap repo (aashutoshrathi/homebrew-tap) under Casks/toki.rb.
# scripts/update-cask.sh regenerates the version + sha256 after each release.
cask "toki" do
  arch arm: "arm64", intel: "x86_64"

  version "3.4.6"
  # update-cask.sh replaces this after each release
  sha256 arm: "c8093ed1c29641ea82283e912971135508d2f12426a9ed689012ec1efc6e628e", intel: "2cad6e7f116ff74a9cd621f90286b6c585fbed4c1706b756786c538d4eb264eb"

  url "https://github.com/aashutoshrathi/toki/releases/download/v#{version}/Toki_#{version}_#{arch}.dmg"
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
