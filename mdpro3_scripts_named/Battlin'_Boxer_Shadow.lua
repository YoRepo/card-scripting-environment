--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Battlin' Boxer Shadow  (ID: 35537251)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 4
-- ATK 1800 | DEF 1400
-- Setcode: 0x1084
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase: You can detach 1 material from a "Battlin' Boxer" Xyz Monster you control,
-- and if you do, Special Summon this card from your hand.
-- You can only use this effect of "Battlin' Boxer Shadow" once per turn.
--[[ __CARD_HEADER_END__ ]]

--BK シャドー
function c35537251.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35537251,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,35537251)
	e1:SetTarget(c35537251.sptg)
	e1:SetOperation(c35537251.spop)
	c:RegisterEffect(e1)
end
function c35537251.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1084) and c:IsType(TYPE_XYZ)
end
function c35537251.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Group.CreateGroup()
		local mg=Duel.GetMatchingGroup(c35537251.cfilter,tp,LOCATION_MZONE,0,nil)
		local tc=mg:GetFirst()
		while tc do
			g:Merge(tc:GetOverlayGroup())
			tc=mg:GetNext()
		end
		if g:GetCount()==0 then return false end
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c35537251.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local mg=Duel.GetMatchingGroup(c35537251.cfilter,tp,LOCATION_MZONE,0,nil)
	local tc=mg:GetFirst()
	while tc do
		g:Merge(tc:GetOverlayGroup())
		tc=mg:GetNext()
	end
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
