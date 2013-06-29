# First Ajax Project

This project is a simple secret sharing project. I've written two
models: `User` and `Secret`. I've also built `UsersController` and
`SessionsController` to do login for you.

## Phase I: `form_for` secrets

Write a `/users/123/secrets/new` form. Use `form_for`. You'll need to
create a nested route.

Clarification: When you post a secret, you are sharing it to someone's
'wall'. The recipient is going to be the user who's id is in the
url. For example, `/users/123/secrets/new` is going to create a secret
where `User` 123 is the recipient. You should not need any hidden
fields or other form fields to accomplish this.

## Phase II: Add friendships (remote `button_to`)

Write a `Friendship` model to join `User` to `User`. Friendship is
one-way in this application. Write a simple `Friendships` controller
(the only action needed is `create`, I think). Nest a `friendship`
resource inside the `users` resource. Friending someone should be as
simple as POSTing to `/users/123/friendship`.

On the `/users` page, list all users, and add a `friend` button for
each. Make this button remote. When clicked, change the button text to
"Friending..." (use `ajax:before`), and disable. On `ajax:success`,
change text to "Friended".

When the template is first rendered, appropriately grey-out the button
if the user has already been friended.

**NB**: To change the text on a clicked button, you will have to find
the button. Here are some hints:

* the `Event` object that is passed to your handler (check both `$.on`
  and `$.Event` contains a `currentTarget` attribute.
    * The target is also available as `this` inside the handler.
* You can use the `find` method to do a CSS selector search for
  elements **nested inside** a jQuery element.
* There are two ways to find a submit button inside a form:
    0. Give the button an id or class and look for that.
    0. Search for `input` tags where the `type` is `"submit"`.
    0. Try both ways. Definitely lookup how to do a CSS search by
       attribute value.

## Phase III: Remove friendships

All things must end; you grow apart. You're still proud of your
friend, but you don't stay in touch anymore.

Add a second button, to unfriend a user. You'll need a `destroy`
action on `FriendshipsController`.

You now want to the unfriend button to appear when you are friends,
and the friend button to appear when you are not. The cleanest way to
do this is to:

0. Writeboth buttons, display them both.
0. Place the two buttons in a div or span, give this a CSS
   class of `friend_buttons`. Likewise, give your buttons classes of
   `friend` and `unfriend`.
0. If we are friends, set a second class on your div:
   `friended`. Otherwise, set `unfriended`
0. Write a CSS rule so that `.friend_buttons.friended friend` is
   `visibility: hidden`. Do likewise for `.friend_buttons.unfriended
   unfriend`.
0. Lastly, your `ajax:success` method needs only to swap a class (see
   `$.toggleClass`).

## Interlude: RESTful design and nested resources

Notice how the friend/unfriend action has been written in terms of a
nested `friendship` resource. This is a common pattern: take a verb
action, think of the noun that might be created by that action, and
nest that as a resource. This is one of the secrets to nice, RESTful
designs.

## Phase IV: Remote secrets form

We have a `/users/123/secrets/new` page that displays a form. I'd like
to be able to post a new secret directly from the `/users/123` page.

Move the `new.html.erb` template into a partial (perhaps
`_form.html.erb`). Make the form remote. Render the partial in
`users/show.html.erb` page.

On successful submission, add the new secret to the `ul` listing all
the secrets. Clear the form so the user can submit again :-)

## Phase V: Simple dynamic form (no nesting)

Let's allow users to tag secrets when they create them. Add `Tag` and
`SecretTagging` models. Set up appropriate associations.

Because `Secret` `has_many :tags, :through => :secret_taggings`, we
can use `Secret#tag_ids=`. We saw how to tag a secret with many tags
through a set of checkboxes. But what if there are lots of tags to
choose from? Do we really want to present 100 checkboxes?

Instead, let's present a single `select` tag. Let's also present a
link "Add another tag". Clicking this link should invoke a JS function
that will add another `select` tag.

### JSON data script trick

Creating new `select` tags means you'll have to create `option` tags:
one for each `Tag`. To give your JavaScript code access to the list of
`Tag`s, I'd store the JSONified `Tag`s in an HTML script tag:

```html+erb
<script type="application/json" id="tags_json" >
  <%= Tag.all.to_json %>
</script>
```

You can then use these client-side via:

```javascript
var tag_objects = JSON.parse($("#tags_json").html());
```

### Underscore template trick

When the user clicks the "Add another tag" link, we need to insert
another select box into the form. Since this involves building HTML to
inject into the form, we can use an underscore template.

I would make a partial called `secrets/_tag_select.html`. Note that I
don't say `.erb`, since this is going to contain an underscore
template. The template should not be processed server-side; we want to
send the template, unprocessed, to the client, so that it can be
rendered client-side by underscore.

```html+erb
<script type="text/template" id="tag_select">
  <% unique_num = (new Date).getTime() %>
  <% input_id = "secret_tag_ids_" + unique_num %>
  <% name = "secret[tag_ids][]" %>

  // code for select and options...
</script>
```

Now, inside your `secrets/_form.html.erb` partial, I would add:

```html+erb
<!-- we'll learn a better way to include JS templates soon. Promise! -->
<%= File.read("./app/views/secrets/_tag_select.html").html_safe %>

<%= form_for(@secret) do |f| %>
  <!-- ... -->
<% end %>
```

Finally, add a link tag, and install a click handler. Your handler
could run something like:

```javascript
function addAnotherTagHandler() {
  var template_code = $("#tag_select").html();
  var template_fn = _.template(template_code);
  var rendered_content = template_fn();

  $("ul.tag_selects").append(rendered_content);
}
```
