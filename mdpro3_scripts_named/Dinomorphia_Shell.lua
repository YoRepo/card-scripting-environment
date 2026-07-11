--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Dinomorphia Shell  (ID: 25419323)
-- Type: Trap / Counter
-- Setcode: 0x173
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of your opponent's Battle Phase: Pay half your LP; Special Summon 1 "Dinomorphia Token"
-- (Dinosaur/DARK/Level 10/ATK 0/DEF 3000), and if you do, for the rest of this turn, while you control
-- that Token in your Monster Zone, your opponent cannot target other monsters for attacks, except that
-- one.
-- During damage calculation, while your LP are 2000 or less, if you would take battle damage: You can
-- banish this card from your GY; you take no battle damage from that battle.
-- You can only activate 1 "Dinomorphia Shell" per turn.
--[[ __CARD_HEADER_END__ ]]

--ダイノルフィア・シェル
function c25419323.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCountLimit(1,25419323+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c25419323.condition)
	e1:SetCost(c25419323.cost)
	e1:SetTarget(c25419323.target)
	e1:SetOperation(c25419323.operation)
	c:RegisterEffect(e1)
	--negate damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c25419323.damcon)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c25419323.damop)
	c:RegisterEffect(e2)
end
function c25419323.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE_START and Duel.GetTurnPlayer()==1-tp
end
function c25419323.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c25419323.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,25419324,0,TYPES_TOKEN_MONSTER,0,3000,10,RACE_DINOSAUR,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c25419323.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,25419324,0,TYPES_TOKEN_MONSTER,0,3000,10,RACE_DINOSAUR,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,25419324)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c25419323.atklimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	token:RegisterEffect(e1)
end
function c25419323.atklimit(e,c)
	return c~=e:GetHandler()
end
function c25419323.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=2000 and Duel.GetBattleDamage(tp)>0
end
function c25419323.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
