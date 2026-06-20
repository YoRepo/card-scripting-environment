--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 威风妖怪龙卷  (ID: 36183881)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 208
--
-- Effect Text:
-- ①：把自己场上1只魔法师族·风属性怪兽解放，以对方场上1只怪兽为对象才能发动。那只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--マジェスペクター・トルネード
function c36183881.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c36183881.cost)
	e1:SetTarget(c36183881.target)
	e1:SetOperation(c36183881.activate)
	c:RegisterEffect(e1)
end
function c36183881.cfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c36183881.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c36183881.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c36183881.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c36183881.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c36183881.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
