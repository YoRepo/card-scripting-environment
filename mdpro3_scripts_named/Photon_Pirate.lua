--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Photon Pirate  (ID: 36834155)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 3
-- ATK 1000 | DEF 1000
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can banish 1 "Photon" monster from your Graveyard; this card gains 1000 ATK until the End Phase.
-- You can use the effect of "Photon Pirate" up to twice per turn.
--[[ __CARD_HEADER_END__ ]]

--フォトン・パイレーツ
function c36834155.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36834155,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2,36834155)
	e1:SetCost(c36834155.cost)
	e1:SetOperation(c36834155.operation)
	c:RegisterEffect(e1)
end
function c36834155.cfilter(c)
	return c:IsSetCard(0x55) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c36834155.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c36834155.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c36834155.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c36834155.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
