$(document).ready(function () {
    (function ($) {
        "use strict";

        jQuery.validator.addMethod('answercheck', function (value, element) {
            return this.optional(element) || /^\bcat\b$/.test(value);
        }, "Type the correct answer -_-");

        // Initialize form validation
        $('#contactForm').validate({
            rules: {
                name: {
                    required: true,
                    minlength: 2
                },
                subject: {
                    required: true,
                    minlength: 4
                },
                number: {
                    required: true,
                    minlength: 5
                },
                email: {
                    required: true,
                    email: true
                },
                message: {
                    required: true,
                    minlength: 20
                }
            },
            messages: {
                name: {
                    required: "Come on, you have a name, don't you?",
                    minlength: "Your name must consist of at least 2 characters"
                },
                subject: {
                    required: "Come on, you have a subject, don't you?",
                    minlength: "Your subject must consist of at least 4 characters"
                },
                number: {
                    required: "Come on, you have a number, don't you?",
                    minlength: "Your number must consist of at least 5 characters"
                },
                email: {
                    required: "No email, no message"
                },
                message: {
                    required: "Um...yeah, you have to write something to send this form.",
                    minlength: "That's all? Really?"
                }
            },
            submitHandler: function (form) {
                $(form).ajaxSubmit({
                    type: "POST",
                    data: $(form).serialize(),
                    url: "contact_process.php",
                    success: handleSuccess,
                    error: handleError
                });
            }
        });

        function handleSuccess() {
            $('#contactForm :input').attr('disabled', 'disabled');
            $('#contactForm').fadeTo("slow", 1, function () {
                $(this).find(':input').attr('disabled', 'disabled');
                $(this).find('label').css('cursor', 'default');
                $('#success').fadeIn();
                $('.modal').modal('hide');
                $('#success').modal('show');
            });
        }

        function handleError() {
            $('#contactForm').fadeTo("slow", 1, function () {
                $('#error').fadeIn();
                $('.modal').modal('hide');
                $('#error').modal('show');
            });
        }

    })(jQuery);
});