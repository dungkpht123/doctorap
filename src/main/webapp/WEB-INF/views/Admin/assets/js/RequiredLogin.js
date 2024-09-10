document.addEventListener('DOMContentLoaded', function() {
		// General Validator setup
	    function setupValidator(formSelector, rules) {
	        Validator({
	            form: formSelector,
	            errorSelector: '.form-message',
	            rules: rules
	        });
	    }

	    // Apply validation rules to different forms
	    setupValidator('#formSubmit', [
	        Validator.isRequired('#email', 'Vui lòng nhập email'),
	        Validator.isRequired('#password', 'Vui lòng nhập mật khẩu')
	    ]);

	    setupValidator('#forgotPasswordForm', [
	        Validator.isRequired('#forgotPasswordEmail', 'Vui lòng nhập email')
	    ]);	
	     setupValidator('#resetPasswordForm', [
	        Validator.isRequired('#newPassword', 'Vui lòng nhập mật khẩu'),
	         Validator.isRequired('#confirmPassword', 'Vui lòng nhập lại mật khẩu')
	    ]);	
	     setupValidator('#verifyCodeForm', [
	        Validator.isRequired('#resetCode', 'Vui lòng nhập mã code 6 số')
	       
	    ]);	
	});


   

