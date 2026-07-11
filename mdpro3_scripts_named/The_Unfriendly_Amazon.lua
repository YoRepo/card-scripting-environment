--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: The Unfriendly Amazon  (ID: 65475294)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 2000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Offer 1 of your monsters on the field as a Tribute (excluding this monster) during each of your
-- Standby Phases.
-- If you cannot, this card is destroyed.
-- Monsters used for a Tribute Summon or that are offered as Tributes due to other cards' effects are
-- excluded.
--[[ __CARD_HEADER_END__ ]]

--味方殺しの女騎士
function c65475294.initial_effect(c)
	--cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c65475294.costcon)
	e1:SetOperation(c65475294.costop)
	c:RegisterEffect(e1)
end
function c65475294.costcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c65475294.costop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.CheckReleaseGroupEx(tp,nil,1,REASON_MAINTENANCE,false,c) and Duel.SelectEffectYesNo(tp,c,aux.Stringid(65475294,0)) then
		local g=Duel.SelectReleaseGroupEx(tp,nil,1,1,REASON_MAINTENANCE,false,c)
		Duel.Release(g,REASON_MAINTENANCE)
	else
		Duel.Destroy(c,REASON_COST)
	end
end
