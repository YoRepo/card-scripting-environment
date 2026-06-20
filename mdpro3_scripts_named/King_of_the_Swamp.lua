--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 沼地的魔神王  (ID: 79109599)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 500 | DEF 1100
--
-- Effect Text:
-- ①：融合怪兽融合召唤的场合，手卡·场上·墓地的这张卡可以作为那只融合怪兽有卡名记述的1只融合素材怪兽代用（其他的融合素材不能代用）。
-- ②：把这张卡从手卡丢弃去墓地才能发动。从卡组把1张「融合」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--沼地の魔神王
function c79109599.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79109599,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c79109599.cost)
	e1:SetTarget(c79109599.target)
	e1:SetOperation(c79109599.operation)
	c:RegisterEffect(e1)
	--fusion substitute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e2:SetCondition(c79109599.subcon)
	c:RegisterEffect(e2)
end
function c79109599.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
function c79109599.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c79109599.filter(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c79109599.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79109599.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c79109599.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c79109599.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
