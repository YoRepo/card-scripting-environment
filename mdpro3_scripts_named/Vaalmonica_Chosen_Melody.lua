--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Vaalmonica Chosen Melody  (ID: 31971040)
-- Type: Trap
-- Setcode: 0x1a3
-- Scope: OCG / TCG
--
-- Effect Text:
-- Apply 1 of these effects.
-- You must control a "Vaalmonica" Monster Card to activate and to resolve this effect.
-- If you control a "Vaalmonica" Link Monster, you can apply both effects in sequence.
-- ● Gain 500 LP, also for the rest of this turn, your opponent cannot target "Vaalmonica" Monster
-- Cards you control with card effects.
-- ● Take 500 damage, then you can negate the effects of 1 Effect Monster your opponent controls, until
-- the end of this turn.
-- You can only activate 1 "Vaalmonica Chosen Melody" per turn.
--[[ __CARD_HEADER_END__ ]]

--選律のヴァルモニカ
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_DESTROY+CATEGORY_DAMAGE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1a3) and c:GetOriginalType()&TYPE_MONSTER>0
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function s.afilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1a3) and c:IsType(TYPE_LINK)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp,op)
	if op==nil and not s.condition(e,tp) then return end
	local c=e:GetHandler()
	if op==nil then
		local chk=Duel.IsExistingMatchingCard(s.afilter,tp,LOCATION_MZONE,0,1,nil)
		op=aux.SelectFromOptions(tp,
			{true,aux.Stringid(id,1)},
			{true,aux.Stringid(id,2)},
			{chk,aux.Stringid(id,3)})
	end
	if op&1>0 and Duel.Recover(tp,500,REASON_EFFECT)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetTargetRange(LOCATION_ONFIELD,0)
		e1:SetTarget(s.target)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(aux.tgoval)
		Duel.RegisterEffect(e1,tp)
		if op==3 then Duel.BreakEffect() end
	end
	if op&2>0 and Duel.Damage(tp,500,REASON_EFFECT)>0 then
		local g=Duel.GetMatchingGroup(aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,nil)
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,4)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
			local sg=g:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			local tc=sg:GetFirst()
			Duel.BreakEffect()
			Duel.NegateRelatedChain(tc,RESET_TURN_SET)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			tc:RegisterEffect(e2)
		end
	end
end
function s.target(e,c)
	return c:IsSetCard(0x1a3) and c:GetOriginalType()&TYPE_MONSTER>0
end
