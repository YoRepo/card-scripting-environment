--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 威风妖怪风暴  (ID: 13972452)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 208
--
-- Effect Text:
-- ①：把自己场上1只魔法师族·风属性怪兽解放，以对方场上1只怪兽为对象才能发动。那只怪兽回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--マジェスペクター・ストーム
function c13972452.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c13972452.cost)
	e1:SetTarget(c13972452.target)
	e1:SetOperation(c13972452.activate)
	c:RegisterEffect(e1)
end
function c13972452.cfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c13972452.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c13972452.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c13972452.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c13972452.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c13972452.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
