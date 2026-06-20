--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 阿斯旺的亡灵  (ID: 88236094)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 500 | DEF 500
--
-- Effect Text:
-- 这张卡对对方造成战斗伤害时，可以将自己墓地里的1张陷阱卡弹回卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--アスワンの亡霊
function c88236094.initial_effect(c)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88236094,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c88236094.condition)
	e1:SetTarget(c88236094.target)
	e1:SetOperation(c88236094.operation)
	c:RegisterEffect(e1)
end
function c88236094.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c88236094.filter(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToDeck()
end
function c88236094.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c88236094.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88236094.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c88236094.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c88236094.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
