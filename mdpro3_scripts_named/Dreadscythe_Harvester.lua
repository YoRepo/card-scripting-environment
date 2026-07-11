--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dreadscythe Harvester  (ID: 66973070)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 8
-- ATK 2300 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 Insect-Type monster to have this card gain 500 ATK until the end of the turn.
--[[ __CARD_HEADER_END__ ]]

--デスサイズ・キラー
function c66973070.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66973070,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c66973070.atkcost)
	e1:SetOperation(c66973070.operation)
	c:RegisterEffect(e1)
end
function c66973070.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,e:GetHandler(),RACE_INSECT) end
	local sg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,e:GetHandler(),RACE_INSECT)
	Duel.Release(sg,REASON_COST)
end
function c66973070.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
