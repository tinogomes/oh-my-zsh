function rspec_with () {
	grep -l $1 spec/*/*_spec.rb | xargs rspec
}

function rspec_all_step_by_step () {
	echo '\n**********************************************************'
	echo 'Migration and preparing db for tests'
	bundle exec rake db:migrate db:test:prepare
	
	dirs=($(find spec -type d -depth 1 ! -name factories ! -name support ! -name fixtures ! -name javascripts ! -name tmp)) 
	for dirname in $dirs
	do
		echo '\n**********************************************************'
		echo "$dirname specs"
		RAILS_ENV=test bundle exec rspec $dirname
	done
	
	echo '\n**********************************************************'
	echo 'javascript specs'
	RAILS_ENV=test bundle exec rake spec:javascript
	
	echo '\n**********************************************************'
	echo 'integration specs'
	RAILS_ENV=test bundle exec rspec features/*_spec.rb
	
	echo
}
