#README - Paperclip


![alt text](http://3.bp.blogspot.com/-5Lf_8oLkokY/T7QL3_c8HhI/AAAAAAAAA2Q/OVPW8IbPBbQ/s1600/clip.jpg "Clip")


##Requirements
1. Ruby and Rails
* ImageMagick
* `brew install imagemagick `
*  `which convert`
* will show you that path of where IM should be installed
* In config/environments/development.rb put `Paperclip.options[:command_path] = "/usr/local/bin/"`
* for pdfs you need to install *GhostScript*
* `brew install gs`


##Create a quick model

`rails g model Post title:string body:string image:attachment`

######Running the above code will generate the following fields in the DB:

* image_file_name # The original filename of the image.
* image_content_type # The mime type of the image
* image_file_size # The file size of the image
* image_updated_at # The last updated date of the image.

###Don't forget to include gem in your Gemfile

`gem "paperclip", "~> 4.3"`

OR

`gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"`

--> will go and grab the latest version of Paperclip


##Sample Model

class Post < ActiveRecord::Base
has_attached_file :image, styles:{ medium:"300x300>", thumb: "100x100>" },
default_url: "/images/:style/missing.png"
validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

--> Note that we can add default CSS styles/properties to the class object

##Edit and New Views

`<%= form_for @post, html: { multipart: true } do |form| %>
<%= form.file_field :image %>
<% end %>`

--> the **form_field** is a form helper which tells the server to look for a file 

###Migration Generator

`rails generate paperclip user avatar`

##Validation!

NOTE: Starting at version 4.0.0, all attachments are required to include a content_type validation, a file_name validation, or to explicitly state that they're not going to have either. Paperclip will raise an error if you do not do this.

```
class ActiveRecord::Base
	has_attached_file :avatar
	# Validate content type
	validates_attachment_content_type :avatar, content_type: /\Aimage/
	# Validate filename
	validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]
	# Explicitly do not validate
	do_not_validate_attachment_file_type :avatar
end
```

###Useful Links
* [Video tutorial for setup](https://youtu.be/Z5W-Y3aROVE "link to youtube")
* [Github for Paperclip](https://github.com/thoughtbot/paperclip "link to github")





