$(document).ready(function(){

    // Create
    $("#create_post").click(function(e) {
        var post_name = $("#hident1").val();
        var post_text = $("#hident2").val();
        if (post_name.length > 0 && 
            post_text.length > 0) {
            
            var conf = confirm("Are you sure?");
            e.preventDefault();
            if(conf) {
                var form =$("#form_new_post");
            
                //Authorized
                appendInfoForm(form,'authorized',true);
                
                form.submit();
            }
        } else {
            alert("The post must have a name and text");
        }
    });

    // Modify
    $("#modify_post").click(function(e) {
        var post_name = $("#hident1").val();
        var post_text = $("#hident2").val();
        if (post_name.length > 0 && 
            post_text.length > 0) {
            
            var conf = confirm("Are you sure?");
            e.preventDefault();
            if(conf) {
                var form =$("#form_modify_post");
            
                //Authorized
                appendInfoForm(form,'authorized',true);
                
                form.submit();
            }
        } else {
            alert("The post must have a name and text");
        }
    });
    
    // Delete
    $(".delete_post").click(function(e) {
        var conf = confirm("Are you sure?");
        e.preventDefault();
        if(conf) {
            var post_id = $(this).parent().attr("id");
            var form =$("#form_delete_post");
            
            //Authorized
            appendInfoForm(form,'authorized',true);
            
            form.submit();
        }
    });

    // Create comment
    $("#create_comment").click(function(e) {
        var name = $("#comment_name").val();
        var text = $("#comment_text").val();
        if (name.length > 0 && 
            text.length > 0) {
            
            var conf = confirm("Are you sure?");
            e.preventDefault();
            if(conf) {
                var form =$("#form_new_comment");
            
                //Authorized
                appendInfoForm(form,'authorized',true);
                
                form.submit();
            }
        } else if (text.length > 0) {            
            var conf = confirm("The comment will be anonymous, are you sure?");
            e.preventDefault();
            if(conf) {
                var form =$("#form_new_comment");

                $("#comment_name").val("Anonymous")
            
                //Authorized
                appendInfoForm(form,'authorized',true);
                
                form.submit();
            }
        } else {
            alert("The post must have a name and text");
        }
    });

});