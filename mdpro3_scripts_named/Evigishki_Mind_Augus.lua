--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 邪遗式心灵女食人魔  (ID: 11877465)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level 6
-- ATK 2500 | DEF 2000
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式魔法卡降临。这张卡仪式召唤成功时，选择双方墓地存在的卡合计最多5张，回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・マインドオーガス
function c11877465.initial_effect(c)
	c:EnableReviveLimit()
	--return to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11877465,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c11877465.condition)
	e1:SetTarget(c11877465.target)
	e1:SetOperation(c11877465.operation)
	c:RegisterEffect(e1)
end
function c11877465.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c11877465.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsAbleToDeck() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,5,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c11877465.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
