--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Blackwing - Abrolhos the Megaquake  (ID: 31053337)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 7
-- ATK 2600 | DEF 1800
-- Setcode: 0x33
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- This card cannot destroy monsters by battle.
-- If this card battles a monster, after damage calculation: Return that monster to the hand.
-- Once per turn, during your Main Phase 1: You can have this card lose exactly 1000 ATK, and if you
-- do, return all cards in your opponent's Spell & Trap Zone to the hand.
--[[ __CARD_HEADER_END__ ]]

--BF－激震のアブロオロス
function c31053337.initial_effect(c)
	--special summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--to hand1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31053337,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c31053337.condition)
	e2:SetTarget(c31053337.target)
	e2:SetOperation(c31053337.operation)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c31053337.indestg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--to hand2
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(31053337,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLED)
	e4:SetOperation(c31053337.operation2)
	c:RegisterEffect(e4)
end
function c31053337.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c31053337.filter(c)
	return c:IsAbleToHand() and c:GetSequence()<5
end
function c31053337.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttack()>=1000 and Duel.IsExistingMatchingCard(c31053337.filter,tp,0,LOCATION_SZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c31053337.filter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c31053337.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetMatchingGroup(c31053337.filter,tp,0,LOCATION_SZONE,nil)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		c:RegisterEffect(e1)
	end
end
function c31053337.indestg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c31053337.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc:IsRelateToBattle() then
		Duel.SendtoHand(bc,nil,REASON_EFFECT)
	end
end
