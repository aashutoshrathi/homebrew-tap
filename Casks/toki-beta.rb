# Homebrew Cask for Toki (beta channel).
#
# This file belongs in a tap repo (aashutoshrathi/homebrew-tap) under Casks/toki-beta.rb.
# scripts/update-cask.sh regenerates the version + sha256 after each release; prerelease
# tags must pass their full version explicitly (e.g. 2.5.0-beta.1).
#
# The beta cask tracks GitHub prereleases. A stable tag bumps this cask too, so a beta
# user is carried onto the graduated stable build by a plain `brew upgrade` - brew's
# version ordering already ranks 2.5.0 above 2.5.0-beta.N.
cask "toki-beta" do
  arch arm: "arm64", intel: "x86_64"

  version "3.4.6"
  # update-cask.sh replaces this after each release
  sha256 arm: "c8093ed1c29641ea82283e912971135508d2f12426a9ed689012ec1efc6e628e", intel: "2cad6e7f116ff74a9cd621f90286b6c585fbed4c1706b756786c538d4eb264eb"

  # Prerelease tags publish the same per-architecture DMGs as stable; the filename carries
  # the base version, so the download URL combines the full tag with the base-version name.
  url "https://github.com/aashutoshrathi/toki/releases/download/v#{version}/Toki_#{version.split('-').first}_#{arch}.dmg"
  name "Toki (Beta)"
  desc "Menu bar companion for AI coding agents and usage (beta channel)"
  homepage "https://github.com/aashutoshrathi/toki"

  depends_on macos: :sonoma

  app "Toki.app"

  conflicts_with cask: "toki"

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
    Toki (beta) tracks prerelease builds and conflicts with the stable `toki` cask;
    install only one. The app is ad-hoc signed and not notarized. If macOS still blocks
    it, open it once with:
      Right-click Toki in Applications > Open
    or clear quarantine manually:
      xattr -dr com.apple.quarantine /Applications/Toki.app
  EOS
end
