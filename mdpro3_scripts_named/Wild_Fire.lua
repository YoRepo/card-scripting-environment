--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Wild Fire  (ID: 68815401)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pay 500 LP; destroy all "Blaze Accelerator" cards you control, and if you do, destroy as many
-- monsters on the field as possible, then, Special Summon 1 "Wild Fire Token" (Pyro/FIRE/Level 3/ATK
-- 1000/DEF 1000) in Attack Position.
-- Your monsters cannot attack the turn you activate this card.
--[[ __CARD_HEADER_END__ ]]

--クレイジー・ファイヤー
function c68815401.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCost(c68815401.cost)
	e1:SetTarget(c68815401.target)
	e1:SetOperation(c68815401.activate)
	c:RegisterEffect(e1)
end
function c68815401.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) and Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 end
	Duel.PayLPCost(tp,500)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c68815401.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0xb9)
end
function c68815401.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c68815401.filter1,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,68815402,0,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP_ATTACK) end
	local dg1=Duel.GetMatchingGroup(c68815401.filter1,tp,LOCATION_SZONE,0,nil)
	local dg2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	dg1:Merge(dg2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg1,dg1:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c68815401.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg1=Duel.GetMatchingGroup(c68815401.filter1,tp,LOCATION_SZONE,0,nil)
	if Duel.Destroy(dg1,REASON_EFFECT)>0 then
		local dg2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if Duel.Destroy(dg2,REASON_EFFECT)>0
			and Duel.IsPlayerCanSpecialSummonMonster(tp,68815402,0,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP_ATTACK) then
			Duel.BreakEffect()
			local token=Duel.CreateToken(tp,68815402)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
	end
end
