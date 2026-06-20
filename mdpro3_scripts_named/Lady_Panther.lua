--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 女豹佣兵  (ID: 38480590)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1400 | DEF 1300
--
-- Effect Text:
-- 表侧表示的这张卡做祭品。1只这个回合被战斗破坏送去墓地的自己的怪兽回到卡组的最上面。
--[[ __CARD_HEADER_END__ ]]

--女豹の傭兵
function c38480590.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c38480590.cost)
	e1:SetTarget(c38480590.target)
	e1:SetOperation(c38480590.operation)
	c:RegisterEffect(e1)
end
function c38480590.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c38480590.filter(c,tid)
	return c:IsType(TYPE_MONSTER) and c:GetTurnID()==tid and c:IsReason(REASON_BATTLE) and c:IsAbleToDeck()
end
function c38480590.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c38480590.filter(chkc,tid) end
	if chk==0 then return Duel.IsExistingTarget(c38480590.filter,tp,LOCATION_GRAVE,0,1,nil,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c38480590.filter,tp,LOCATION_GRAVE,0,1,1,nil,tid)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c38480590.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
