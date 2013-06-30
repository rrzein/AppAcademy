# First Ajax Project

This project is a simple secret sharing project. I've written two
models: `User` and `Secret`. I've also built `UsersController` and
`SessionsController` to do login for you.

## Phase I: `form_for` secrets

Write a `/users/123/secrets/new` form. Use `form_for`. You'll need to
create a nested route.

## Phase II: Add friendships

Write a `Friendship` model to join `User` to `User`. Friendship is
one-way in this application. Write a simple `Friendships` controller
(the only action needed is `create`, I think).

On the `/users` page, list all users, and add a `friend` button for
each. Make this button remote. When clicked, change the button text to
"Friending..." (use `ajax:before`), and disable. On `ajax:success`,
change text to "Friended".

When the template is first rendered, appropriately grey-out the button
if the user has already been friended.

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
   `visible: false`. Do likewise for `.friend_buttons.unfriended
   unfriend`.
0. Lastly, your `ajax:success` method needs only to swap a class (see
   `$.toggleClass`).
