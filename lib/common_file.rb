# frozen_string_literal: true

module CommonFile
  def self.extract_content_type(filepath)
    IO.popen(["file", "--mime-type", "--brief", filepath]) do |io|
      io.read.chomp
    end
  end
end
