module ApplicationHelper
  # app/helpers/application_helper.rb
  def webpack_bundle_tag(bundle)
    src =
      if Rails.configuration.webpack[:use_manifest]
        manifest = Rails.configuration.webpack[:asset_manifest]
        filename = manifest[bundle]

        "#{compute_asset_host}/assets/#{filename}"
      else
        dev_server_url = 'http://localhost:3500'
        "#{dev_server_url}/assets/#{bundle}-bundle.js"
      end

    javascript_include_tag(src)
  end

  def webpack_manifest_script
    return '' unless Rails.configuration.webpack[:use_manifest]
    javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest]}"
  end
end
