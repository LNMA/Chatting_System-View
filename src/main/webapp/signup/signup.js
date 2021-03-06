/*jshint esversion: 6 */
/*jshint sub:true*/
function signUpValidateForm() {
    'use strict';
    let username = document.forms['signUpForm']['username'].value;
    let password = document.forms['signUpForm']['password'].value;
    let firstName = document.forms['signUpForm']['firstName'].value;
    let lastName = document.forms['signUpForm']['lastName'].value;
    let gender = document.forms['signUpForm']['gender'].value;
    let birthday = document.forms['signUpForm']['birthday'].value;
    let telephone = document.forms['signUpForm']['telephone'].value;
    let email = document.forms['signUpForm']['email'].value;
    let country = document.forms['signUpForm']['country'].value;

    if ((username === '') || (password === '') || (firstName === '') || (lastName === '') || (gender === '') ||
        (birthday === '') || (email === '') || (telephone === '') || (country === '')) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> All required field must be filled.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    let telNum = parseFloat(telephone);
    if (isNaN(telNum)) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Telephone number must be integer number.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (/\s/.test(username) || /\s/.test(password)) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Username and password must not contain whitespace.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (username.length < 4) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Username length must be at least 4 character.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (password.length < 8) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Password must be at least 8 character.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (/[^0-9]/.test(telephone)) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Telephone number must be integer number.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if ((/\W+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/.test(email))) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Email form you entered is wrong.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }
}