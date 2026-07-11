--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: The Weather Thundery Canvas  (ID: 16849715)
-- Type: Trap / Continuous
-- Setcode: 0x109
-- Scope: OCG / TCG
--
-- Effect Text:
-- "The Weather" Effect Monsters in your Main Monster Zones of this card's column and its adjacent
-- columns gain this effect.
-- ● At the start of the Damage Step, if this card battles an opponent's monster: You can banish this
-- card; return that opponent's monster to the hand.
-- You can only control 1 "The Weather Thundery Canvas".
--[[ __CARD_HEADER_END__ ]]

--雷の天気模様
function c16849715.initial_effect(c)
	c:SetUniqueOnField(1,0,16849715)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16849715,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c16849715.retcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c16849715.rettg)
	e2:SetOperation(c16849715.retop)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c16849715.eftg)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c16849715.eftg(e,c)
	local seq=c:GetSequence()
	return c:IsType(TYPE_EFFECT) and c:IsSetCard(0x109)
		and seq<5 and math.abs(e:GetHandler():GetSequence()-seq)<=1
end
function c16849715.retcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and c:IsRelateToBattle() and bc:IsRelateToBattle()
end
function c16849715.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c16849715.retop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.SendtoHand(bc,nil,REASON_EFFECT)
	end
end
