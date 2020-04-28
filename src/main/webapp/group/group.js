/*jshint esversion: 6 */
/*jshint sub:true*/
$(document).on('click', '#inputStringPost', function () {
    'use strict';
    let post = '<form class=\"form-group\" action=\"../AddGroupTextPost\" method=\"post\">' +
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
    let post = '<form class=\"form-group\" action=\"../AddGroupImgPost\" method=\"post\" enctype=\"multipart/form-data\">\n' +
        '                        <div class=\"custom-file\">\n' +
        '                            <input type=\"file\" class=\"custom-file-input\" id=\"inputFile\" name=\"filename\" accept=\"image/*\">\n' +
        '                            <label class=\"custom-file-label\" for=\"inputFile\">Choose file...</label>' +
        '                        </div>\n' +
        '                        <script>\n' +
        '                            // Add the following code if you want the name of the file appear on select \n' +
        '                            $(\".custom-file-input\").on(\"change\", function() { \n' +
        '                                let fileName = $(this).val().split(\"\\\\").pop(); \n' +
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
    let idGroup = document.forms['CreateGroupForm']['idGroup'].value;
    let privacy = document.forms['CreateGroupForm']['privacy'].value;
    let activity = document.forms['CreateGroupForm']['activity'].value;

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

$(window).on('load', function () {
    'use strict';
    $('#changeGroupImageModal').append(`<div class="modal fade" id="GImageModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">Change Group Picture</h4>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <form action="../UpdateUserProfile" method="post" enctype="multipart/form-data">
                    <input type="text" value="pGroup0img1c" name="fieldCode" readonly hidden>
                    <div class="modal-body">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="inputFileModal" name="filename" accept="image/*">
                            <label class="custom-file-label" for="inputFileModal">Choose file...</label>
                        </div>
                        <script>
                            // Add the following code if you want the name of the file appear on select
                            $(".custom-file-input").on("change", function() {
                                let fileName = $(this).val().split("\\\\").pop();
                                $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
                            });
                        </script>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">
                            Sava
                        </button>
                        <button type="button" class="btn btn-danger"
                                data-dismiss="modal">Close
                        </button>

                    </div>
                </form>
            </div>
        </div>
    </div>`);
});

$(window).on('load', function () {
    'use strict';
    $('#changeGroupPrivacyModal').append(`<div class="modal fade" id="gPrivacyModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">Change Group Privacy</h4>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <form name="privacyForm" action="../UpdateUserProfile" method="post" onsubmit="return fNameValidateForm()">
                    <input type="text" value="pGroup1privacy2c" name="fieldCode" readonly hidden>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <div id="privacyAlert"></div>
                            <div class="row row-cols-md-2">
                                <div class="col-md-4">
                                    <label class="font-weight-bold col-md-12" for="inputPrivacy">Group Privacy: </label>
                                </div>
                                <div class="col-md-6">
                                    <select class="custom-select w-75" name="privacy" id="inputPrivacy">
                                        <option selected disabled value="">Choose...</option>
                                        <option value="public">Public</option>
                                        <option value="private">Private</option>
                                        <option value="hidden">Hidden</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">
                            Save
                        </button>
                        <button type="button" class="btn btn-danger"
                                data-dismiss="modal">Close
                        </button>

                    </div>
                </form>
            </div>
        </div>
    </div>`);
});

$(window).on('load', function () {
    'use strict';
    $('#changeGroupActivityModal').append(`<div class="modal fade" id="gActivityModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">Change Group Activity</h4>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <form name="activityForm" action="../UpdateUserProfile" method="post" onsubmit="return fNameValidateForm()">
                    <input type="text" value="pGroup2Activity3c" name="fieldCode" readonly hidden>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <div id="activityAlert"></div>
                            <div class="row row-cols-md-2">
                                <div class="col-md-4">
                                    <label class="font-weight-bold col-md-12" for="inputActivity">Group Activity: </label>
                                </div>
                                <div class="col-md-6">
                                    <input class="form-control w-100" type="text" maxlength="60" name="activity"
                                           id="inputActivity" placeholder="Type Group Activity"/>                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">
                            Save
                        </button>
                        <button type="button" class="btn btn-danger"
                                data-dismiss="modal">Close
                        </button>

                    </div>
                </form>
            </div>
        </div>
    </div>`);
});