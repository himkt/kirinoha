# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

BATCH_SIZE = 1000
SEASON = ['春', '秋']
MODULE = ['A', 'B', 'C']
DAYS = %w(月 火 水 木 金 土 日)
DAYS_REGEXP = /[#{DAYS.join('|')}][\d|\,・]*+/
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

  daytime_string.split(/\n/)
  ordinals = daytime_string.scan(/#{DAYS_REGEXP}/)
  others = daytime_string.gsub(/#{ordinals.join('|')}|\n/, '')

  # '火5, 6' => '火5 火6'
  #
  ordinals_with_hour = ordinals.map { |daytime|
    day = daytime[0]
    hours = daytime.scan(/\d/)
    hours.map {|hour| "#{day}#{hour}"}.join(' ')
  }

  unless others.blank?
    ordinals_with_hour << others
  end

  return ordinals_with_hour
end


fname = Dir.glob("vendor/dataset/kdb_*?.xlsx")[0]
raise Exception.new("\n\nXLSX file not found. Please download from https://kdb.tsukuba.ac.jp\n\n") unless fname

subjects = []

Roo::Excelx.new(fname).each_with_index do |arr, index|
  p arr.size, arr

  next if index <= 4 || arr.size != 17
  puts index

  code, title, _, credits, grade_string, term_string, daytime_string, location, instructor_string, description, notion, ca, condition, _, alternative, _, _, _ = arr

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
  ca_bool = ca.eql?(CA) ? true : false

  next if code =~ /^0[12]/

  subjects << Subject.new(
    :code => code,
    :title => title,
    :credits => credits,
    :grades => grades,
    :terms => terms,
    :daytimes => daytimes,
    :location => location,
    :instructors => instructors,
    :info => "#{description}\n#{notion}",
    :ca => ca_bool,
    :condition => condition,
    :alternative => alternative
  )

  puts code, title
end

i = 1

subjects.in_groups_of(BATCH_SIZE, false) {|arr|
  Subject.import arr
  puts "iter: #{i}"
  i += 1
}
