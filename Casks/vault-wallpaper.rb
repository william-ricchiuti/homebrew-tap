cask "vault-wallpaper" do
  version "1.0.0-beta.1"
  sha256 "b03a567088bf989b1b6eb97b409f68bfb9fe183ad0f63e5d9fe28092f123319f"

  url "https://github.com/william-ricchiuti/vault-wallpaper/releases/download/v#{version}/Vault-Wallpaper-#{version}.dmg"
  name "Vault Wallpaper"
  desc "Obsidian vault graph as a live desktop wallpaper"
  homepage "https://github.com/william-ricchiuti/vault-wallpaper"

  # Betas are GitHub pre-releases, which :github_latest skips; :github_releases sees them.
  livecheck do
    url :url
    strategy :github_releases
  end

  # Sparkle updates the app in place, so `brew upgrade` leaves it alone.
  auto_updates true
  # Same as ">= :ventura"; current `brew style` wants the bare symbol (Homebrew/OSDependsOn).
  depends_on macos: :ventura

  app "Vault Wallpaper.app"

  # Start at Login registers the app as a login item; remove it with the app.
  uninstall quit:       "com.williamricchiuti.vaultwallpaper",
            login_item: "Vault Wallpaper"

  # Settings, layout cache and custom presets; WebKit data from the settings window; Sparkle's
  # state lives under Caches and Preferences. Exported PNGs in ~/Pictures are the user's.
  zap trash: [
    "~/Library/Application Support/Vault Wallpaper",
    "~/Library/Caches/com.williamricchiuti.vaultwallpaper",
    "~/Library/HTTPStorages/com.williamricchiuti.vaultwallpaper",
    "~/Library/Preferences/com.williamricchiuti.vaultwallpaper.plist",
    "~/Library/Saved Application State/com.williamricchiuti.vaultwallpaper.savedState",
    "~/Library/WebKit/com.williamricchiuti.vaultwallpaper",
  ]
end
