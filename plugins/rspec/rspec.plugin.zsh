# Execure all spec that contains <pattern>
# 
# Sintax: rspec-with <pattern>
function rspec-with () {
	files=($(grep -l -E $1 spec/*/*_spec.rb))
	
	for file in $files; do
		echo '\n**********************************************************'
		echo "rspec $file $2"
		RAILS_ENV=test bundle exec rspec $file $2 || pause
	done
}

# Execute all spec step by step, oh baby
function rspec-all-sbs () {
	echo '\n**********************************************************'
	echo 'Migration and preparing db for tests'
	bundle exec rake db:migrate db:test:prepare
	
	dirs=($(find spec -type d -depth 1 ! -name factories ! -name support ! -name fixtures ! -name javascripts ! -name tmp)) 
	for dirname in $dirs
	do
		echo '\n**********************************************************'
		echo "$dirname specs"
		RAILS_ENV=test bundle exec rspec $* $dirname
	done
	
	echo '\n**********************************************************'
	echo 'javascript specs'
	RAILS_ENV=test bundle exec rake spec:javascript
	
	echo '\n**********************************************************'
	echo 'integration specs'
	RAILS_ENV=test bundle exec rspec $* features/*_spec.rb
	
	echo
}

# Execute relative specs for implementation
function rrspec() {
	spec_file=$(echo $1 | sed -e 's/app/spec/' -e 's/\.rb$/_spec.rb/' -e 's/_spec_spec\.rb$/_spec.rb/')
	echo 'rspec '$spec_file
	RAILS_ENV=test bundle exec rspec $spec_file
}
