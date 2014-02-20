Usage
=========

The overlay is contained in a div with a class of "overlayer"

```html
<div class="overlayer">
  <!-- Overlay content here -->
</div>
```

Add a button with the "data-dismiss" attribute set to "overlayer" inside the "overlayer" container to add a button to close the overlay

```html
<div class="overlayer">
  <button data-dismiss="overlayer">x</button>
</div>
```

Finally add a button with the "data-toggle" attribute set to "overlayer" to trigger the display of the overlay

```html
<button data-toggle="overlayer">Click me!</button>
```

And you are ready to go!
