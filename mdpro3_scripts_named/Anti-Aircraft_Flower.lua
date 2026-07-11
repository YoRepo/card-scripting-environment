--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Anti-Aircraft Flower  (ID: 65064143)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 3
-- ATK 0 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- By tributing 1 Insect-Type monster on your side of the field, inflict 800 points of damage to your
-- opponent's Life Points.
--[[ __CARD_HEADER_END__ ]]

--対空放花
function c65064143.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65064143,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c65064143.damcost)
	e1:SetTarget(c65064143.damtg)
	e1:SetOperation(c65064143.damop)
	c:RegisterEffect(e1)
end
function c65064143.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_INSECT) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_INSECT)
	Duel.Release(g,REASON_COST)
end
function c65064143.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,800)
end
function c65064143.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
