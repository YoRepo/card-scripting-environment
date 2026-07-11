--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Nightmell the Dark Bonder  (ID: 66569334)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level: 4
-- ATK 1500 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 monster; Special Summon from your Deck, 1 monster with the same original Type,
-- Attribute, Level, and ATK/DEF as the Tributed monster, but with a different original name.
-- If you Tributed a monster Special Summoned from the Extra Deck, you can Special Summon a monster
-- from your Extra Deck instead that meets those same criteria.
-- You can only use this effect of "Nightmell the Dark Bonder" once per turn.
--[[ __CARD_HEADER_END__ ]]

--悪醒師ナイトメルト
function c66569334.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66569334,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,66569334)
	e1:SetCost(c66569334.spcost)
	e1:SetTarget(c66569334.sptg)
	e1:SetOperation(c66569334.spop)
	c:RegisterEffect(e1)
end
function c66569334.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c66569334.cfilter(c,e,tp)
	local loc=nil
	if c:IsSummonLocation(LOCATION_EXTRA) then loc=LOCATION_DECK+LOCATION_EXTRA else loc=LOCATION_DECK end
	return (c:IsControler(tp) or c:IsFaceup()) and c:IsLevelAbove(0)
		and Duel.IsExistingMatchingCard(c66569334.spfilter,tp,loc,0,1,nil,c,e,tp)
end
function c66569334.spfilter(c,mc,e,tp)
	return c:IsLevel(mc:GetOriginalLevel()) and not c:IsOriginalCodeRule(mc:GetOriginalCodeRule())
		and c:IsRace(mc:GetOriginalRace()) and c:IsAttribute(mc:GetOriginalAttribute())
		and c:GetTextAttack()==mc:GetTextAttack() and c:GetTextDefense()==mc:GetTextDefense()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (not c:IsLocation(LOCATION_EXTRA) and Duel.GetMZoneCount(tp,c)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0)
end
function c66569334.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c66569334.cfilter,1,nil,e,tp)
	end
	local c=e:GetHandler()
	local g=Duel.SelectReleaseGroup(tp,c66569334.cfilter,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local loc=nil
	if tc:IsSummonLocation(LOCATION_EXTRA) then
		e:SetLabel(1)
		loc=LOCATION_DECK+LOCATION_EXTRA
	else
		e:SetLabel(0)
		loc=LOCATION_DECK
	end
	e:SetLabelObject(tc)
	Duel.Release(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,loc)
end
function c66569334.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local rc=e:GetLabelObject()
	local loc=nil
	if e:GetLabel()==1 then loc=LOCATION_DECK+LOCATION_EXTRA else loc=LOCATION_DECK end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66569334.spfilter,tp,loc,0,1,1,nil,rc,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
