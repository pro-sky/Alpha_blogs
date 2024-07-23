$(document).ready(function () {
    let editor_configuration = {
    toolbar: {
    items: [
        "bold",
        "italic",
        "link",
        "underline",
        "bulletedList",
        "numberedList",
        "|",
        "blockQuote",
    ],
    },
    simpleUpload: {
    uploadUrl: "/file_uploads/upload",
    headers: {
        "X-CSRF-Token": document.querySelectorAll('meta[name="csrf-token"]')[0]
        .content,
    },
    },
    language: "en",
    updateSourceElementOnDestroy: true,
    removePlugins: ['ImageCaption']
    };

    // Configuration for the comment editor
    let comment_editor_configuration = {
    ...editor_configuration,
    placeholder: "Add a new comment..."
    };

    let article_editor_configuration = {
        ...editor_configuration,
        placeholder: "Add article description..."
    };

    ClassicEditor.create(document.querySelector("#article-editor"), article_editor_configuration)
    .then((articleEditor) => {
    window.article_editor = articleEditor;
    })
    .catch((error) => {
    console.log(error);
    });

    ClassicEditor.create(document.querySelector("#editor"), comment_editor_configuration)
    .then((newWebEditor) => {
    window.editor = newWebEditor;
    })
    .catch((error) => {
    console.log(error);
    });
});

