class WickedPdf
	@@config = Rails.env.production? ?
		{ exe_path: Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s } :
		{	exe_path: Rails.root.join('bin', 'wkhtmltopdf-i386' ).to_s }
	cattr_accessor :config

  def initialize(wkhtmltopdf_binary_path = nil)
    @exe_path = wkhtmltopdf_binary_path
    @exe_path ||= WickedPdf.config[:exe_path] unless WickedPdf.config.empty?
    @exe_path ||= `which wkhtmltopdf`.chomp
    raise "Location of wkhtmltopdf unknown" if @exe_path.empty?
    raise "Bad wkhtmltopdf's path" unless File.exists?(@exe_path)
    raise "Wkhtmltopdf is not executable" unless File.executable?(@exe_path)
  end
end