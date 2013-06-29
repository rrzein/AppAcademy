ToDo = {};

ToDo.show = function(event) {
		var list_idx = ($('.list').index(this));
		var list_template_code = $('.listItems').html();
		var list_template_fn = _.template(list_template_code);
		var list_items_content = list_template_fn({ list: LISTS[list_idx] });
		$(this).toggleClass('hidden').toggleClass('displayed');
		$(this).append(list_items_content);
		$(this).off();
		$(this).on('click', 'a', ToDo.hide);
		var $subitems = $($(this).find('#Items'));
		console.log($subitems);
		var $button = $($(this).find('.deleteItem'));
		$button.on('click', ToDo.deleteItem)

	}

ToDo.hide = function(event) {
		var parent = $(this).parent();
		var items = $($(parent).find('.Items'));
		$(items).remove();
		$(parent).on('click', ToDo.show);
	};

ToDo.appendNewList = function(event, data) {
		var $title = $('.listForm input[type="text"]');
		var $list = $('<li class="list hidden">');
		var $link = $('<a href="#">');
		var $itemLink = $link.text($title.val());

		$list.append($itemLink);

		$('.lists ul').append($list);
		LISTS.push(data);
	};

ToDo.allListsSelect = function() {
		var select_template_code = $('.listLists').html();
		var select_template_fn = _.template(select_template_code);
		var select_lists_content = select_template_fn({ LISTS: LISTS })
		$('.newItems').append(select_lists_content);
};

ToDo.sendItem = function(item) {

	$.ajax({
		type: 'POST',
		url:'/items',
		data: item,
		success: function(data) {
			var list_index = data.list_id - 1
			LISTS[list_index]["items"].push(data);
			var $list = $($('.list').get(list_index))
			if ($list.is('.displayed')){
				var $items_list = $($list.find('.Items'));
				var $items = $($items_list.find('ul'));
				$items
					.append('<li>' + data.name +'</li>')
					.append('<a href="#"><button type="button" class="deleteItem">√</button></a>')

			}
		}

	});
};

ToDo.addItems = function(event) {
	console.log($('#item_name'));
	$('input#item_name').each(function(index, input_field) {
		if($(this).val() != "") {
			var listID = $('.listSelect option:selected').val();
			var item_name = $(this).val();
			var item = {
				item: {
				list_id: listID,
				name: item_name
				}
			};
			$(this).val("");
			ToDo.sendItem(item);
		}
	});
};

ToDo.addField = function(event) {
	$("input#item_name").last().after('<input type="text" id="item_name" name="item[name]">').after('<br>')
};


ToDo.deleteItem = function(event) {
	console.log(this);
	var parentlist = $(this).closest('.list');
	console.log(parentlist)
	var list_idx = ($('.list').index(parentlist));
	var button_idx = $(parentlist).find('button.deleteItem').index(this);
	console.log(list_idx)
	var item = LISTS[list_idx]["items"][button_idx];

	$.ajax({
		type: 'DELETE',
		url: '/items/' + item.id})

	LISTS[list_idx]["items"].splice(button_idx, 1);

	$(this).closest('li').remove();

};