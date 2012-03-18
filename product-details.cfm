<cfscript>
if (!StructKeyExists(url, "key")) {
	url.key = 'rose-pen';
}
file = "products/" & url.key & ".json";
if (FileExists(ExpandPath(file))) {
	if (cacheKeyExists("products")) {
		products = cacheGet("products");
		if (StructKeyExists(products, url.key)) {
			item = products[key];
		} else {
			abort "Product not found";
		}
	} else {
		location("product-listing.cfm");
	}
} else {
	abort "No Product Found";
}
</cfscript>
<cfprocessingdirective suppressWhitespace="true">
<cfinclude template="header.cfm" />
<cfoutput>
	<div class="item-form-container">
	<div class="step" id="step-one">
		<p style="display: block; margin: 20px 0 0 0;font: bold 12px 'Georgia'; color: ##947057;text-transform: uppercase;">On Sale!</p>
		<span id="item-cost" style="margin: 0 3px 0 0; font: bold 23px 'Georgia'; font-style: italic; color: ##353535;">$0.00</span>
		<div class="form">
			<h1>#item.name#</h1>
			<p>#item.description#</p>
			<cfif StructKeyExists(item, "options_title")>
				<h2>#item.options_title#</h2>
			</cfif>
			<cfif StructKeyExists(item, "options")>
				<cfloop collection="#item.options#" item="i">
					<cfset formItem="#item.options[i]#" />
					<cfif not StructKeyExists(formItem, "type") or formItem.type eq "select">
						<cfset hidden = StructKeyExists(formItem, "depends") ? "display: none" : "" />
						<label class="custom-select" for="#formItem.name#" style="#hidden#">
							<div class="custom-text">#formItem.title#</div>
							<select id="#formItem.name#" name="#formItem.name#" required="#formItem.required#">
								<option value="">- Select One -</option>
								<cfloop collection="#formItem.options#" item="key">
									<cfset itemOption="#formItem.options[key]#" />
									<cfif IsInstanceOf(itemOption, "java.lang.String")>
										<cfif IsNumeric(key)>
											<option value="#key - 1#">#itemOption#</option>
										<cfelse>
											<option value="#htmlEditFormat(key)#">#itemOption#</option>
										</cfif>
									<cfelse>
										<option value="#htmlEditFormat(key)#">#key#</option>
									</cfif>
								</cfloop>
							</select>
							<br />
							<br />
						</label>
					<cfelseif formItem.type eq "checkbox">
						<label class="custom-select" for="#formItem.name#">
							<input type="checkbox" value="1" name="#formItem.name#" id="#formItem.name#" />
							#formItem.title# 
							<br />
							<br />
						</label>
					</cfif>
				</cfloop>
			</cfif>
			<h3>
				Quantity 
				<input type="number" id="qty" name="qty" style="width: 32px;" value="1" />
				<br />
			</h3>
			<form id="submitForm" target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onsubmit="return false;">
				<input type="hidden" name="cmd" value="_cart" />
				<input type="hidden" name="add" value="1" />
				<div id="paypalForm"></div>
				<input type="hidden" name="currency_code" value="USD" />
				<input type="hidden" name="business" value="invadermisty@gmail.com" />
				<input type="submit" id="add_item_btn" value="Add to Cart" style="padding: 1em" disabled="disabled" />
			</form>
			</div> 
			<div style="text-align:center; padding-top: 10px;">
				<img src="http://glamourskull.com/logo_pp_protection.png" width="112" height="57" alt="PayPal Purchase Protection" style="vertical-align: super; margin-right: 10px;" />
			</div>
		</div>
		<!-- step-one -->
	</div>
	<!-- item-form-container -->

<script type="text/javascript">
	var item = #SerializeJSON(item)#;
	var node = document.createElement('script');
	node.type = 'text/javascript';
	node.async = true;
	node.src = 'http://www.glamourskull.com/mootools.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(node, s);

	var checker = setInterval(function () {
		if (typeof MooTools !== 'undefined') {
			clearInterval(checker);
			init(MooTools);
		}
	}, 5);

	function init(MooTools) {
		var funcs = {};
		var generatePaypal = function (name, cost, qty, weight) {
			var div = document.id('paypalForm');
			div.empty();
			var input;
			//-- Name
			input = new Element('input', {
				'type': 'hidden',
				'id': 'item_name',
				'name': 'item_name',
				'value': name,
			});
			input.inject(div);
			//-- Cost
			input = new Element('input', {
				'type': 'hidden',
				'id': 'amount',
				'name': 'amount',
				'value': cost.toFixed(2),
			});
			input.inject(div);
			//-- Qty
			input = new Element('input', {
				'type': 'hidden',
				'id': 'quantity',
				'name': 'quantity',
				'value': qty,
			});
			input.inject(div);
			//-- Shipping
			input = new Element('input', {
				'type': 'hidden',
				'id': 'weight',
				'name': 'weight',
				'value': weight.toFixed(2),
			});
			input.inject(div);
		}
		var calculateTotal = function () {
			var formItems = document.id('step-one').getElements('input, textarea, select');
			var subtotal = 0.00;
			if (typeof item.cost !== 'undefined') {
				var cost = parseInt(item.cost);
				if (isNaN(cost)) {
					cost = 0.00;
				}
				subtotal += cost;
			}
			var total = 0.00;
			var weight = 0.00;
			if (typeof item.weight !== 'undefined') {
				weight = parseFloat(item.weight);
				if (isNaN(weight)) {
					weight = 0.00;
				}
			}
			var qty = parseInt(document.id('qty').get('value'));
			if (isNaN(qty)) {
				qty = 0;
			}
			if (typeof item.maxqty !== 'undefined') {
				var maxqty = item.maxqty;
				if (qty > maxqty) {
					qty = maxqty;
					alert('Sorry, we only have ' + maxqty + ' available. Your quantity '
						+ 'has been adjusted');
					document.id('qty').set('value', maxqty);
				}
			}
			Array.each(formItems, function (elem, i) {
				var value = elem.get('value');
				if (value.length > 0) {
					Array.each(item.options, function (option, i) {
						if (option.name == elem.get('name')) {
							var valueOption;
							if (typeof option.options !== 'undefined') {
								valueOption = option.options[value];
								if (typeof valueOption.cost !== 'undefined') {
									var cost;
									if (typeof valueOption.cost === 'object') {
										Object.each(valueOption.cost, function (valueCost, key) {
											var found = $$('[value="' + key.replace(/"/g, '\"') + '"]:selected');
											if (found.length > 0) {
												cost = parseFloat(valueCost);
											}
										})
									} else {
										//-- Weight
										var subweight = 0.00;
										if (typeof valueOption.weight !== 'undefined') {
											subweight = parseFloat(valueOption.weight);
											if (isNaN(subweight)) {
												subweight = 0.00;
											}
										}
										weight += subweight;
										//-- Cost 
										cost = parseFloat(valueOption.cost);
									}
									
									if (!isNaN(cost)) {
										subtotal += cost;
									}
								}
							} else {
							}
						}
					});
				}
			});
			total = (subtotal * qty).toFixed(2);
			document.id('item-cost').set('text', '$' + total);
			var name = item.name;
			if (typeof item.options_name_layout !== 'undefined') {
				var matches = item.options_name_layout.match(/\{([a-zA-z0-9_]+)\}/g);
				name = item.options_name_layout;
				Array.each(matches, function (match, i) {
					var option = document.id(match.substr(1, match.length - 2));
					name = name.replace(match, option.get('value'));
				})
			}
			generatePaypal(name, subtotal, qty, weight);
			var requiredElems = Array.filter($$('[required=1]'), function (ele, i) { if (ele.getParent('label').getStyle('display') !== 'none') { return true; } else { return false } });
			var filledElems = Array.filter($$('[required=1]'), function (ele, i) { if (ele.getParent('label').getStyle('display') !== 'none') { return ele.get('value').length > 0; } else { return false } });
			if (requiredElems.length !== filledElems.length) {
				$('add_item_btn').set('disabled', 'disabled');
			} else {
				$('add_item_btn').erase('disabled');
				}
		};

		document.id('qty').addEvents({
			'change': calculateTotal,
			'keyup': calculateTotal
		});

		Array.each(item.options, function (option, i) {
			document.id(option.name).addEvent('change', function (evt) {
				calculateTotal();
			});
			if (typeof option.depends !== 'undefined') {
				var formItem = document.id(option.depends[0]);
				if (typeof funcs[option.depends[0]] === 'undefined') {
					funcs[option.depends[0]] = [];
				}

				var depandant;
				Array.each(item.options, function (depandantOption, n) {
					if (depandantOption.name === option.depends[0]) {
						depandant = depandantOption;
					}
				});

				funcs[option.depends[0]].push({
					name: option.name,
					option: depandant,
					depandantOption: option,
					dependant: (option.length > 1) ? option.depends[1] : false
				});
				
				if (formItem.retrieve('changeCallback') === null) {
					formItem.addEvent('change', function (evt) {
						var dependsOn = funcs[this.get('id')];
						var formItem = document.id(this);
						var hasType = typeof dependsOn[0].option.type !== 'undefined';
						//-- Checkbox Logic
						if (hasType && 
							dependsOn[0].option.type === 'checkbox') {
							var label = $$('[for=' + option.name + ']');
							if (document.id(this).checked) {
								label.setStyles({display: 'inline-block'});
							} else {
								//-- TODO: What is this is not a select?
								document.id(option.name).set('value', '').getSelected().erase('selected');
								label.setStyles({display: 'none'});
							}
						}
						//-- Select Logic
						if ((hasType && 
							dependsOn[0].option.type === 'select') || !hasType) {
							Array.each(dependsOn, function (depOpt, j) {
								var name = depOpt.depandantOption.name;
								var label = $$('[for="' + name + '"]');
								if (depOpt.depandantOption.depends[1] === formItem.get('value')) {
									label.setStyles({display:'inline-block'});
								} else {
									document.id(name).value = null;
									document.id(name).set('value', '').getSelected().erase('selected');
									label.setStyles({display:'none'});
								}
							});
						}

						calculateTotal();
					});
					formItem.store('changeCallback', true);
				}
			}
		});
		calculateTotal();
		document.id('add_item_btn').addEvent('click', function (evt) {
			document.id(this).getParent('form').submit();
		});
		Array.each($$('.item-image-secondary'), function (img,i) {
			img.addEvents({
				'click': function (evt) {
					$$('.item-image-secondary.active').removeClass('active');
					this.addClass('active');
					$('displayImage').set('src', this.get('src').replace('tiny', 'small'));
				}
			});
		});
	}
</script>
</cfoutput>
<cfinclude template="footer.cfm" />
</cfprocessingdirective>