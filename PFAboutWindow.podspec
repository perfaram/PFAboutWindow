Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "PFAboutWindow"
  s.version      = "1.1.1"
  s.summary      = "A replacement for the 'About' dialog."

  s.description  = <<-DESC
                   A sleek replacement for the otherwise bleak 'About' dialog.
                   Its nice, looks like xCode6's one, and offers the following abilities

                   * Open the app's website by clicking its (big) icon (in the dialog) (see Usage below),
                   * Extend the dialog to show the 'License Agreement', or
                   * The 'Acknowledgments' (see Content below),
                   * Translate the button's text (see Localization below),
                   * Change the background and text colors
                   DESC

  s.homepage     = "https://github.com/perfaram/PFAboutWindow"
  s.screenshots  = "https://raw.githubusercontent.com/perfaram/PFAboutWindow/master/screenshots/PFAboutWindow.gif"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = "Perceval FARAMAZ"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.osx.deployment_target = "10.9"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/perfaram/PFAboutWindow.git" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "PFAboutWindow/**/*.{h,m,xib}"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

end
