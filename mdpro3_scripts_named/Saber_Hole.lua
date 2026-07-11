--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Saber Hole  (ID: 44901281)
-- Type: Trap / Counter
-- Setcode: 0xd
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster(s) would be Summoned, while you control an "X-Saber" monster: Negate the Summon, and
-- if you do, destroy that monster(s).
--[[ __CARD_HEADER_END__ ]]

--セイバー・ホール
function c44901281.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c44901281.condition)
	e1:SetTarget(c44901281.target)
	e1:SetOperation(c44901281.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
end
function c44901281.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x100d)
end
function c44901281.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44901281.filter,tp,LOCATION_MZONE,0,1,nil)
		and aux.NegateSummonCondition()
end
function c44901281.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c44901281.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
