# frozen_string_literal: true

# Options for the browser
def scrapping_options
  opts = {
    headless: true
  }

  if Rails.env.production?
    if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
      opts[:options] = { binary: chrome_bin }
    end
  else
    chrome_bin = '/usr/bin/google-chrome'
    opts[:options] = { binary: chrome_bin }
  end
  opts
end

def replace_underscore_by_space(string)
  string.tr('_', ' ')
end
