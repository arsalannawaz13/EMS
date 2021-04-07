$(document).on('ready turbolinks:load', () => {
	toggleSignUp();
})

function toggleSignUp(){
	$('#new-ems').on('click', function(){
		$('#sign-up-form').removeClass('d-none');
	})
}