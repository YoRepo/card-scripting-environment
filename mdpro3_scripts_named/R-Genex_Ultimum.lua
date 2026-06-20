--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 真次世代终极人  (ID: 46572756)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 1400
-- Setcode: 4098
--
-- Effect Text:
-- ①：场上的表侧表示的这张卡被破坏送去墓地时，以自己墓地2只「次世代」怪兽为对象才能发动。那些怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--レアル・ジェネクス・ウルティマム
function c46572756.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46572756,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c46572756.condition)
	e1:SetTarget(c46572756.target)
	e1:SetOperation(c46572756.operation)
	c:RegisterEffect(e1)
end
function c46572756.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP)
end
function c46572756.filter(c)
	return c:IsSetCard(0x2) and c:IsAbleToDeck()
end
function c46572756.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c46572756.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46572756.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c46572756.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c46572756.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
