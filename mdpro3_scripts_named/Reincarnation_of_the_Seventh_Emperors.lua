--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Reincarnation of the Seventh Emperors  (ID: 57499304)
-- Type: Trap
-- Setcode: 0x175
-- Scope: OCG / TCG
--
-- Effect Text:
-- During damage calculation, if your "Number" Xyz Monster that has a number between "101" and "107" in
-- its name, or your Xyz Monster that has any such monsters as material, battles: Banish that monster
-- you control (also banish its materials).
-- During the End Phase of the turn you activated this card, Special Summon 1 Rank 3 or lower Xyz
-- Monster from your Extra Deck, except a "Number" monster, and if you do, inflict damage to your
-- opponent equal to its original ATK.
--[[ __CARD_HEADER_END__ ]]

--七皇転生
function c57499304.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c57499304.condition)
	e1:SetTarget(c57499304.target)
	e1:SetOperation(c57499304.activate)
	c:RegisterEffect(e1)
end
function c57499304.filter(c)
	local no=aux.GetXyzNumber(c)
	return no and no>=101 and no<=107 and c:IsSetCard(0x48) and c:IsType(TYPE_XYZ)
end
function c57499304.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetBattleMonster(tp)
	if not tc then return false end
	if not tc:IsType(TYPE_XYZ) then return false end
	if c57499304.filter(tc) then return true end
	local g=tc:GetOverlayGroup()
	return g:IsExists(c57499304.filter,1,nil)
end
function c57499304.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetBattleMonster(tp)
	local g=tc:GetOverlayGroup()
	if chk==0 then return tc:IsAbleToRemove() and #g==g:FilterCount(Card.IsAbleToRemove,nil) end
	Duel.SetTargetCard(tc)
	g:AddCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,#g,0,0)
end
function c57499304.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetBattleMonster(tp)
	if tc and tc:IsRelateToEffect(e) and tc:IsControler(tp) then
		local og=tc:GetOverlayGroup()
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_REMOVED) and og:GetCount()>0 then
			Duel.Remove(og,POS_FACEUP,REASON_EFFECT)
		end
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetOperation(c57499304.spop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c57499304.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,57499304)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c57499304.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
end
function c57499304.spfilter(c,e,tp)
	return not c:IsSetCard(0x48) and c:IsRankBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
