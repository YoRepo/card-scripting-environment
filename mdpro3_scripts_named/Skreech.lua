--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 尖叫怪  (ID: 27655513)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 4
-- ATK 1500 | DEF 400
--
-- Effect Text:
-- 这张卡被战斗破坏的场合，从自己卡组选择2只水属性怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--スクリーチ
function c27655513.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27655513,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c27655513.condition)
	e1:SetTarget(c27655513.target)
	e1:SetOperation(c27655513.operation)
	c:RegisterEffect(e1)
end
function c27655513.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_BATTLE)
end
function c27655513.filter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToGrave()
end
function c27655513.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_DECK)
end
function c27655513.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c27655513.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,2,2,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
