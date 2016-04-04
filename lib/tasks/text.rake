namespace :text do
  task :preprocessing do

    fname = Dir.glob("vendor/dataset/kdb_*?.xlsx")[0]
    raise Exception.new("\n\nXLSX file not found. Please download from https://kdb.tsukuba.ac.jp\n\n") unless fname

    s = Roo::Excelx.new(fname)
    s.each_with_index do |arr, index|
      next if index <= 3
      record = []
      arr.each_with_index do |item, index_2|
        next if index_2 == 2 || index_2 == 14
        if item != nil
          item = "#{item.to_s.gsub(/\n/, '')}"
        end
        record.push(item)
      end
      puts record.join("\t").sub(/\t$/,'')
    end
  end
end
