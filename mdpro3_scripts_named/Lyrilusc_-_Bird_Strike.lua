--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Lyrilusc - Bird Strike  (ID: 56619778)
-- Type: Spell
-- Setcode: 0xf7
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Lyrilusc" monster: Negate the effects of all face-up monsters your opponent
-- currently controls, until the end of this turn.
-- You can only activate 1 "Lyrilusc - Bird Strike" per turn.
--[[ __CARD_HEADER_END__ ]]

--LL－バード・ストライク
function c56619778.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,56619778+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c56619778.condition)
	e1:SetTarget(c56619778.target)
	e1:SetOperation(c56619778.activate)
	c:RegisterEffect(e1)
end
function c56619778.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf7)
end
function c56619778.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c56619778.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c56619778.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,g:GetCount(),0,0)
end
function c56619778.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
