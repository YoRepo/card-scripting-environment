--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 异怪之妖精 艾尔佛彼娅  (ID: 44663232)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 3
-- ATK 900 | DEF 500
--
-- Effect Text:
-- ①：1回合1次，把手卡1只风属性怪兽给对方观看才能发动。直到下次的对方主要阶段1结束时，双方不能把比给人观看的怪兽等级高的怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--異怪の妖精 エルフォビア
function c44663232.initial_effect(c)
	--activate limit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44663232,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c44663232.cost)
	e2:SetOperation(c44663232.operation)
	c:RegisterEffect(e2)
end
function c44663232.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and not c:IsPublic()
end
function c44663232.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44663232.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c44663232.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabel(g:GetFirst():GetLevel())
	Duel.ShuffleHand(tp)
end
function c44663232.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetLabel(e:GetLabel()+1)
	e1:SetReset(RESET_PHASE+PHASE_MAIN1+RESET_OPPO_TURN)
	e1:SetValue(c44663232.val)
	Duel.RegisterEffect(e1,tp)
end
function c44663232.val(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsLevelAbove(e:GetLabel())
end
