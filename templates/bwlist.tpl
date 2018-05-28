{include file='header.tpl' title='Black/whitelist'}
<style>
	.popover-content {
		overflow: hidden;
		text-overflow: ellipsis;
	}
</style>
<div class="container-fluid">
	<div class="col-md-7 col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					{t}Black/whitelist{/t}
					<a class="pull-right" data-toggle="collapse" href="#search">
						<span class="fa fa-search"></span>
					</a>
					<a id="link-add" class="pull-right visible-sm visible-xs" style="margin-right: 15px;">
						<span class="fa fa-plus"></span>
					</a>
				</h3>
			</div>
			<div id="search" class="{if $search}collapse in{else}collapse{/if}" aria-expanded="{if $search}true{else}false{/if}">
				<div class="panel-body">
					<form class="form-horizontal" method="get">
						<input type="hidden" name="page" value="{$page_active}">
						<input type="hidden" name="limit" value="{$limit}">
						<div class="form-group">
							<label class="col-sm-2 control-label">{t}Action{/t}</label>
							<div class="col-sm-10">
								<select name="action" class="form-control">
									<option value="">{t}Select action{/t}</option>
									<option value="blacklist" {if $search.action == 'blacklist'}selected="selected"{/if}>{t}Blacklist{/t}</option>
									<option value="whitelist" {if $search.action == 'whitelist'}selected="selected"{/if}>{t}Whitelist{/t}</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">{t}Sender{/t}</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" placeholder="{t}Search for...{/t}" name="sender" value="{$search.sender|escape}">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">{t}For recipient{/t}</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" placeholder="{t}Search for...{/t}" name="recipient" value="{$search.recipient|escape}">
							</div>
						</div>
						<button class="btn btn-primary pull-right" type="search"><span class="fa fa-search"></span></button>
					</form>
				</div>
			</div>
			<table class="table table-hover table-fixed">
				<thead class="hidden-xs">
					<tr>
						<th style="width: 80px">{t}Action{/t}</th>
						<th>{t}Sender{/t}</th>
						<th>{t}For recipient{/t}</th>
						<th style="width: 30px"></th>
						<th style="width: 30px"></th>
						<th style="width: 30px"></th>
					</tr>
				</thead>
				<tbody>
				{foreach from=$items key=type item=item}
					{foreach from=$item key=value item=itemdata}
						{if count($itemdata.accesses) > 1}
							{$toggle_id = $toggle_id + 1}
							<tr data-toggle="{$toggle_id}" data-type="{$type|escape}" data-value="{$value|escape}" data-access="{implode(',', $itemdata.accesses)|escape}" class="toggle">
								<td class="hidden-xs" style="width: 80px"><span class="label label-{if $type=='whitelist'}success{elseif $type=='blacklist'}danger{else}info{/if}">{if $type=='whitelist'}{t}Whitelist{/t}{else}{t}Blacklist{/t}{/if}</span></td>
								<td class="hidden-xs">{$value|escape}</td>
								<td class="hidden-xs" colspan="2"><span class="badge">{count($itemdata.accesses)}</span></td>
								<td class="visible-xs" colspan="2">
									<dl class="dl-horizontal dl-horizontal-xs">
										<dt>{t}Action{/t}</dt><dd><span class="label label-{if $type=='whitelist'}success{elseif $type=='blacklist'}danger{else}info{/if}">{if $type=='whitelist'}{t}Whitelist{/t}{else}{t}Blacklist{/t}{/if}</span></dd>
										<dt>{t}Sender{/t}</dt><dd>{$value|escape}</dd>
										<dt>{t}For recipient{/t}</dt><dd><span class="badge">{count($itemdata.accesses)}</span></dd>
									</dl>
								</td>
								<td style="width: 30px; vertical-align: middle"><span class="expand-icon fa fa-expand"></span></td>
								<td style="width: 30px; vertical-align: middle">
									<a class="bwlist_delete" title="{t}Remove{/t}"><i class="fa fa-remove"></i></a>
								</td>
							</tr>
							{foreach from=$itemdata.accesses key=i item=access}
							{$item_id = $item_id + 1}
							<tr id="item-{$item_id}" data-type="{$type|escape}" data-value="{$value|escape}" data-comment="{$itemdata.comments.$i|escape}" data-access="{$access|escape}" style="display: none" class="item item-hidden hidden-{$toggle_id} info">
								<td class="item-type hidden-xs" style="width: 80px"><span class="label label-{if $type=='whitelist'}success{elseif $type=='blacklist'}danger{else}info{/if}">{if $type=='whitelist'}{t}Whitelist{/t}{else}{t}Blacklist{/t}{/if}</span></td>
								<td class="item-value hidden-xs">{$value|escape}</td>
								<td class="item-access hidden-xs">{if $access}{$access|escape}{else}<span class="text-muted">{t}everyone{/t}</span>{/if}</td>
								<td class="visible-xs">
									{if $access}{$access|escape}{else}<span class="text-muted">{t}everyone{/t}</span>{/if}
								</td>
								<td style="width: 30px; vertical-align: middle"  {if !empty({$itemdata.comments.$i})}data-toggle="popover" data-placement="left" data-container="body" data-trigger="focus hover" data-content="{$itemdata.comments.$i|escape}"{/if}>
									{if !empty({$itemdata.comments.$i})}
									<a title="{t}Comment{/t}"><i class="fa fa-info-circle"></i></a>
									{/if}
								</td>
								<td style="width: 30px; vertical-align: middle">
									<a title="{t}Edit{/t}"><i class="fa fa-pencil-square-o"></i></a>
								</td>
								<td style="width: 30px; vertical-align: middle">
									<a class="bwlist_delete" title="{t}Remove{/t}"><i class="fa fa-remove"></i></a>
								</td>
							</tr>
							{/foreach}
						{else}
							{$item_id = $item_id + 1}
							<tr id="item-{$item_id}" data-type="{$type|escape}" data-value="{$value|escape}" data-comment="{$itemdata.comments.0|escape}" data-access="{$itemdata.accesses.0|escape}" class="item">
								<td class="item-type hidden-xs" style="width: 80px"><span class="label label-{if $type=='whitelist'}success{elseif $type=='blacklist'}danger{else}info{/if}">{if $type=='whitelist'}{t}Whitelist{/t}{else}{t}Blacklist{/t}{/if}</span></td>
								<td class="item-value hidden-xs">{$value|escape}</td>
								<td class="item-access hidden-xs">{if $itemdata.accesses.0}{$itemdata.accesses.0|escape}{else}<span class="text-muted">{t}everyone{/t}</span>{/if}</td>
								<td class="visible-xs">
									<dl class="dl-horizontal dl-horizontal-xs">
										<dt>{t}Action{/t}</dt><dd><span class="label label-{if $type=='whitelist'}success{elseif $type=='blacklist'}danger{else}info{/if}">{if $type=='whitelist'}{t}Whitelist{/t}{else}{t}Blacklist{/t}{/if}</span></dd>
										<dt>{t}Sender{/t}</dt><dd>{$value|escape}</dd>
										<dt>{t}For recipient{/t}</dt><dd>{if $itemdata.accesses.0}{$itemdata.accesses.0|escape}{else}<span class="text-muted">{t}everyone{/t}</span>{/if}</dd>
										{if !empty($itemdata.comments.0)}
										<dt>{t}Comment{/t}</dt><dd>{$itemdata.comments.0|escape}</dd>
										{/if}
									</dl>
								</td>
								<td style="width: 30px; vertical-align: middle" {if !empty({$itemdata.comments.0})}data-toggle="popover" data-placement="left" data-container="body" data-trigger="focus hover" data-content="{$itemdata.comments.0|escape}"{/if}>
									{if !empty({$itemdata.comments.0})}
									<a title="{t}Comment{/t}"><i class="fa fa-info-circle"></i></a>
									{/if}
								</td>
								<td style="width: 30px; vertical-align: middle">
									<a title="{t}Edit{/t}"><i class="fa fa-pencil-square-o"></i></a>
								</td>
								<td style="width: 30px; vertical-align: middle">
									<a class="bwlist_delete" title="{t}Remove{/t}"><i class="fa fa-remove"></i></a>
								</td>
							</tr>
						{/if}
					{/foreach}
				{foreachelse}
					<tr><td colspan="6" class="text-muted">{t}No black/whitelist{/t}</td></tr>
				{/foreach}
				</tbody>
			</table>
		</div>
		{include file='pager.tpl'}
	</div>
	<div class="col-md-5 col-lg-4">
		<div id="side-panel" class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title hidden-edit">{t}Add{/t}</h3>
				<h3 class="panel-title visible-edit hidden">{t}Edit{/t}</h3>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" id="bwlist_add">
					<input type="hidden" id="action" value="add">
					<input id="edit-id" type="hidden">
					<div class="form-group">
						<label for="type" class="control-label col-md-3">{t}Action{/t}</label>
						<div class="col-md-9">
							<select id="type" class="form-control">
								<option value="0">{t}Select action{/t}</option>
								<option value="blacklist">{t}Blacklist{/t}</option>
								<option value="whitelist">{t}Whitelist{/t}</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">{t}Sender{/t}</label>
						<div class="col-md-9">
							<input type="text" class="form-control" id="value">
							<p class="help-block">
								{t}Sender may be an IP address, an e-mail address, a domain name or a wildcard domain name starting with a dot (eg. .co.uk).{/t}
							</p>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">{t}Comment{/t}</label>
						<div class="col-md-9" id="comment-field">
							<input type="hidden" class="form-control" id="comment-default" value="Added by {$username|escape}">
							<div class="input-group" id="comment-group">
								<div class="input-group-addon">
									<input type="checkbox" id="enable-comment">
								</div>
								<input type="text" class="form-control" id="comment" disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3" style="white-space: nowrap;">{t}For recipient{/t}</label>
						<div class="col-md-9">
							<p id="edit-recipient" class="form-control-static visible-edit hidden"></p>
							{if count($useraccess) == 1}
								<input type="hidden" class="form-control recipient" value="{$useraccess.0|escape}">
								<p class="form-control-static hidden-edit">{$useraccess.0|escape}</p>
							{elseif count($useraccess) > 0}
								<button id="check-all" class="btn btn-info hidden-edit">{t}Select all{/t}</button>
								<button id="add-access" class="btn btn-default hidden-edit">{t}Add custom{/t}</button>
								{if count($useraccess) > 5}<div id="access-panel" class="panel panel-default hidden-edit" style="height: 115px; padding-left: 10px; margin-top: 5px; overflow-y: scroll;">{/if}
								<div id="extra-accesses" class="hidden-edit"></div>
								{foreach $useraccess as $a}
								<div class="checkbox hidden-edit">
									<label>
										<input type="checkbox" class="recipient" value="{$a|escape}"> {$a|escape}
									</label>
								</div>
								{/foreach}
								{if count($useraccess) > 5}</div>{/if}
							{else}
								<input type="text" class="form-control recipient hidden-edit" placeholder="{t}everyone{/t}">
							{/if}
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-offset-3 col-md-9">
							<button id="btn-add" type="submit" class="btn btn-primary hidden-edit">{t}Add{/t}</button>
							<button id="btn-edit" type="submit" class="btn btn-primary visible-edit hidden">{t}Save{/t}</button>
							<button id="btn-cancel" type="button" class="btn btn-default visible-edit hidden">{t}Cancel{/t}</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
{include file='footer.tpl'}
