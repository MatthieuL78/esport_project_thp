# frozen_string_literal: true

def scrapping_options
  opts = {
    headless: true
  }

  if Rails.env.production?
    if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
      opts.merge!( options: {binary: chrome_bin})
    end 
  else
    chrome_bin = '/usr/bin/google-chrome'
    opts.merge!( options: {binary: chrome_bin})
  end
  opts  
end