reset_display() {
  settings=/data/system/users/0/settings_secure.xml

  # sed -e '/display_size_forced/d' $settings
  # sed -e '/display_density_forced/d' $settings
  sed -i '/display_size_forced/d' $settings
  sed -i '/display_density_forced/d' $settings
  chown system:system $settings
}

reset_display
