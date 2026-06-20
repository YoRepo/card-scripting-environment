--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 裁决的天秤  (ID: 67443336)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方场上的卡数量比自己的手卡·场上的卡合计数量多的场合才能发动。自己从卡组抽出那个相差的数量。
--[[ __CARD_HEADER_END__ ]]

--裁きの天秤
function c67443336.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,67443336+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c67443336.condition)
	e1:SetTarget(c67443336.target)
	e1:SetOperation(c67443336.activate)
	c:RegisterEffect(e1)
end
function c67443336.condition(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	local s=Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)
	return t>s
end
function c67443336.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	local s=Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,t-s) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(t-s)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,t-s)
end
function c67443336.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local t=Duel.GetFieldGroupCount(p,0,LOCATION_ONFIELD)
	local s=Duel.GetFieldGroupCount(p,LOCATION_HAND+LOCATION_ONFIELD,0)
	if t>s then
		Duel.Draw(p,t-s,REASON_EFFECT)
	end
end
