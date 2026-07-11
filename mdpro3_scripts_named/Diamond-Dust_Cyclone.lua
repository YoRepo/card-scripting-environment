--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Diamond-Dust Cyclone  (ID: 19980975)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 monster with 4 or more Fog Counters; destroy it, and if you do, draw 1 card for every 4 Fog
-- Counters that was on it.
--[[ __CARD_HEADER_END__ ]]

--ダイヤモンドダスト・サイクロン
function c19980975.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c19980975.target)
	e1:SetOperation(c19980975.activate)
	c:RegisterEffect(e1)
end
function c19980975.filter(c)
	return c:GetCounter(0x1019)>=4
end
function c19980975.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c19980975.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingTarget(c19980975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c19980975.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c19980975.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local ct=math.floor(tc:GetCounter(0x1019)/4)
		if Duel.Destroy(tc,REASON_EFFECT)~=0 and ct~=0 then
			Duel.Draw(tp,ct,REASON_EFFECT)
		end
	end
end
