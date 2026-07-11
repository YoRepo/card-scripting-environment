--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Pulse Mines  (ID: 58464739)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a Machine monster: Change your opponent's Attack Position monsters (if any) to
-- Defense Position, also, until the end of this turn, if a monster(s) is Normal or Special Summoned to
-- your opponent's field, change them to Defense Position.
--[[ __CARD_HEADER_END__ ]]

--パルス・ボム
function c58464739.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c58464739.condition)
	e1:SetTarget(c58464739.target)
	e1:SetOperation(c58464739.activate)
	c:RegisterEffect(e1)
end
function c58464739.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c58464739.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c58464739.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c58464739.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c58464739.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c58464739.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c58464739.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58464739.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c58464739.posop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	Duel.RegisterEffect(e2,tp)
end
function c58464739.posfilter(c,tp)
	return c58464739.filter(c) and c:IsControler(1-tp)
end
function c58464739.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c58464739.posfilter,nil,tp)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end
