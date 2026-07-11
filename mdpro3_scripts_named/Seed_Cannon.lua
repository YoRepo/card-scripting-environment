--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Seed Cannon  (ID: 81524977)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a Plant-Type monster(s) is Summoned, place 1 Plant Counter on this card (max. 5).
-- You can send this card to the Graveyard to inflict 500 damage to your opponent for each Plant
-- Counter on it.
--[[ __CARD_HEADER_END__ ]]

--種子弾丸
function c81524977.initial_effect(c)
	c:EnableCounterPermit(0x20)
	c:SetCounterLimit(0x20,5)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c81524977.ctcon)
	e2:SetOperation(c81524977.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(81524977,0))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCost(c81524977.damcost)
	e5:SetTarget(c81524977.damtg)
	e5:SetOperation(c81524977.damop)
	c:RegisterEffect(e5)
end
function c81524977.ctfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c81524977.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c81524977.ctfilter,1,nil)
end
function c81524977.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x20,1)
end
function c81524977.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabel(e:GetHandler():GetCounter(0x20))
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c81524977.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetCounter(0x20)>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel()*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel()*500)
end
function c81524977.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
