$(document).on('click', '#inputStringPost', function () {
    'use strict';
    var post = '<form class=\"form-group\" action=\"../AddGroupTextPost\" method=\"post\">' +
        '                        <textarea class=\"form-control\" data-toggle=\"collapse\" name=\"post\"  placeholder=\"What\'s want to share with your group?\"></textarea>' +
        '                        <button class=\"btn btn-primary mt-2 col-md-1\" type=\"submit\" name=\"post\" value=\"Post\">Post</button>' +
        '                    </form>' +
        '                </div>';

    $('#addGroupPost').removeAttr('hidden');
    $('#addGroupPost').show();
    $(document.body).find('#addGroupPost').html('');
    $(document.body).find('#addGroupPost').html(post);
});

$(document).on('dblclick', '#inputStringPost', function () {
    'use strict';
    $('#addGroupPost').hide();
});

$(document).on('click', '#inputImg', function () {
    'use strict';
    var post = '<form class=\"form-group\" action=\"../AddGroupImgPost\" method=\"post\" enctype=\"multipart/form-data\">\n' +
        '                        <div class=\"custom-file\">\n' +
        '                            <input type=\"file\" class=\"custom-file-input\" id=\"inputFile\" name=\"filename\" accept=\"image/*\">\n' +
        '                            <label class=\"custom-file-label\" for=\"inputFile\">Choose file...</label>' +
        '                        </div>\n' +
        '                        <script>\n' +
        '                            // Add the following code if you want the name of the file appear on select \n' +
        '                            $(\".custom-file-input\").on(\"change\", function() { \n' +
        '                                var fileName = $(this).val().split(\"\\\\").pop(); \n' +
        '                                $(this).siblings(\".custom-file-label\").addClass(\"selected\").html(fileName); \n' +
        '                            }); \n' +
        '                        </script>\n' +
        '                        <button class=\"btn btn-primary mt-2 col-md-1\" type=\"submit\" value=\"post\">Post</button>\n' +
        '                    </form>\n';

    $('#addGroupPost').removeAttr('hidden');
    $('#addGroupPost').show();
    $(document.body).find('#addGroupPost').html('');
    $(document.body).find('#addGroupPost').html(post);
});

$(document).on('dblclick', '#inputImg', function () {
    'use strict';
    $('#addGroupPost').hide();
});

function creatGroupValidateForm() {
    'use strict';
    var idGroup = document.forms['CreateGroupForm']['idGroup'].value;
    var privacy = document.forms['CreateGroupForm']['privacy'].value;
    var activity = document.forms['CreateGroupForm']['activity'].value;

    if ((idGroup === '') || (privacy === '') || (activity === '')) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> All required field must be filled.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (/\s/.test(idGroup)) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Id group must not contian whitespace.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (idGroup.length < 4) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> Id group length must be at least 4 character.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }

    if (activity.length < 4) {
        document.getElementById('topAlert').innerHTML = '   <div class=\"container\">\n' +
            '        <div class=\"alert alert-danger alert-dismissible\" data-dismiss=\"alert\" id=\"myAlert\">\n' +
            '            <button type=\"button\" class=\"close\">&times;</button>\n' +
            '            <strong>Error!</strong> activity must be at least 4 character.\n' +
            '        </div>\n' +
            '    </div>';
        return false;
    }
}
