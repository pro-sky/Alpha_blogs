# config/initializers/pdfkit.rb
PDFKit.configure do |config|
    # Use wkhtmltopdf-binary gem provided executable path
    # config.wkhtmltopdf = `which wkhtmltopdf`.strip
    # Or specify the path to the wkhtmltopdf executable on your server
    # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  
    config.default_options = {
      page_size: 'A4',
      print_media_type: true
    }
    # Use only if your external hostname is unavailable on the server.
    config.root_url = "http://localhost" 
  end
  
  # Add PDFKit middleware
#   require 'pdfkit'
#   middleware.use PDFKit::Middleware, print_media_type: true