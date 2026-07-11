--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Nidhogg, Generaider Boss of Ice  (ID: 49275969)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Wyrm
-- Level: 9
-- ATK 2100 | DEF 2600
-- Setcode: 0x134
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Nidhogg, Generaider Boss of Ice".
-- When your opponent would Special Summon a monster(s) (Quick Effect): You can Tribute 1 "Generaider"
-- monster or 1 Wyrm monster; negate the Summon, and if you do, destroy that monster(s).
-- You can only use this effect of "Nidhogg, Generaider Boss of Ice" once per turn.
--[[ __CARD_HEADER_END__ ]]

--氷の王 ニードヘッグ
function c49275969.initial_effect(c)
	c:SetUniqueOnField(1,0,49275969)
	--disable special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49275969,0))
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,49275969)
	e1:SetCondition(c49275969.discon)
	e1:SetCost(c49275969.discost)
	e1:SetTarget(c49275969.distg)
	e1:SetOperation(c49275969.disop)
	c:RegisterEffect(e1)
end
function c49275969.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function c49275969.costfilter(c)
	return c:IsSetCard(0x134) or c:IsRace(RACE_WYRM)
end
function c49275969.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c49275969.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c49275969.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c49275969.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c49275969.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
