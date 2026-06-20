--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 小妖精  (ID: 45939611)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 自己的主要阶段时把1张手卡送去墓地才能发动。这张卡的等级上升1星。这个效果1回合可以使用最多2次。
--[[ __CARD_HEADER_END__ ]]

--リトル・フェアリー
function c45939611.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45939611,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetCost(c45939611.cost)
	e1:SetOperation(c45939611.operation)
	c:RegisterEffect(e1)
end
function c45939611.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c45939611.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
