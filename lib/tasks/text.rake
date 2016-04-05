#
# kdb2rails_model
#
# subject data preprocessor
#


SEASON = ['春', '秋']
MODULE = ['A', 'B', 'C']
CA = "×"


def decomp_grade(grade_string)
  if grade_string =~ /・/
    return grade_string.split('・').map { |str| str.tr("０-９", "0-9") }

  elsif grade_string =~ /-/
    start_from, end_to = grade_string.split(' - ').map(&:to_i)
    return (start_from..end_to).to_a.map(&:to_s)

  else
    # because decomp_grade returns #Array, I state []
    return [grade_string]

  end
end


# TODO: more useful decomp
def decomp_term(term_string)

  term_list = term_string.split(/\n/)
  return term_list
end


# TODO: more useful decomp
def decomp_daytime(daytime_string)

  daytime_list = daytime_string.split(/\n/)
  return daytime_list
end


namespace :text do
  task :preprocessing do

    fname = Dir.glob("vendor/dataset/kdb_*?.xlsx")[0]
    raise Exception.new("\n\nXLSX file not found. Please download from https://kdb.tsukuba.ac.jp\n\n") unless fname

    subjects = []

    data = Roo::Excelx.new(fname)
    data.each_with_index do |arr, index|

      next if index <= 4 || arr.size != 15

      code, title, _, credits, grade_string, term_string, daytime_string, location, instructor_string, description, notion, ca, condition, alternative, _ = arr


      # grade

      ## decomposition
      ## string -> [string]
      grade_string = grade_string.to_s || ''
      grade_list = decomp_grade(grade_string)
      ## composition
      ## [string] -> string
      grades = grade_list.join(' ')


      # term

      ## decomposition
      ## string -> [string]
      term_string = term_string || ''
      term_list = decomp_term(term_string)
      ## composition
      ## [string] -> string
      terms = term_list.join(' ')

      # daytime

      ## decomposition
      ## string -> [string]

      daytime_string = daytime_string || ''
      daytime_list = decomp_daytime(daytime_string)
      ## composition
      ## [string] -> string
      daytimes = daytime_list.join(' ')

      # instructors
      instructor_string = instructor_string || ''

      # concatenate lastname and firstname
      instructors = instructor_string.gsub(/\s/, '').split(',').join(' ')

      # ca

      ## value takes 0 or 1
      ca_bool = ca.eql?(CA) ? 1 : 0

      subjects << {
        code: code,
        title: title,
        credits: credits,
        grades: grades,
        terms: terms,
        daytimes: daytimes,
        location: location,
        instructors: instructors,
        info: "#{description}\n#{notion}",
        ca: ca_bool,
        condition: condition,
        alternative: alternative
      }
    end

    begin
      output = open('vendor/dataset/subjects.json', 'w')
      output.puts JSON.generate(subjects)
      output.close
      puts 'Successfully create subjects.json'
      puts 'see vendor/dataset/subjects.json'
    rescue => e
      raise e
    end
  end
end
